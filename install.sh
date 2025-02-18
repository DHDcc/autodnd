#!/bin/sh

autodndSystemdServiceUrl="https://raw.githubusercontent.com/DHDcc/autodnd/refs/heads/main/systemd/autodnd.service"
autodndSystemdServicePath="$HOME/.config/systemd/user/autodnd.service"

autodndBashScriptUrl="https://raw.githubusercontent.com/DHDcc/autodnd/refs/heads/main/src/autodnd"
autodndBashScriptPath="$HOME/.local/bin/autodnd"

if [ "$(id -u)" = 0 ]; then
    printf >&2 "Do not run this script as root.\n"
    exit 1
fi

mkdir --parents "$HOME/.local/bin" "$HOME/.config/systemd/user" || { printf >&2 "Failed to create directories.\n"; exit 1; }

curl -fsSL "$autodndBashScriptUrl" > "$autodndBashScriptPath" || { printf >&2 "Failed to fetch autodnd.\n"; exit 1; }
chmod 700 "$autodndBashScriptPath" && printf ":: Installed autodnd in '$HOME/.local/bin'.\n" 

curl -fsSL "$autodndSystemdServiceUrl" > "$autodndSystemdServicePath" || { printf >&2 "Failed to fetch autodnd.service"; exit 1; }
chmod 644 "$autodndSystemdServicePath" &&  printf ":: Installed autodnd.service in '$HOME/.config/systemd/user'.\n"

if ! systemctl --user daemon-reload; then
    printf >&2 "Failed to reload systemd manager configuration.\n"
    exit 1
else
    printf ":: Reloaded systemd manager configuration.\n"
fi

if ! systemctl --user enable --now autodnd.service &> /dev/null; then
    printf >&2 "Failed to enable and start autodnd.service.\n"
    exit 1
else
    printf ":: Enabled and started autodnd.service.\n"
fi

printf "\n:: Installation has successfully finished!\n"
