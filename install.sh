#!/bin/sh

packageName="autodnd"
systemdServiceName="${packageName}.service"

if [ "$UID" = 0 ]; then
    printf >&2 "Do not run this script as root.\n"
    exit 1
fi

cd "${packageName}" || { echo -e >&2 "Failed to enter directory ${packageName}.\n"; exit 1; }
echo -e "Moved to $PWD\n"

mkdir -p $HOME/.local/bin $HOME/.config/systemd/user || { echo -e >&2 "Failed to create directories.\n"; exit 1; }

if ! install -m 700 "src/${packageName}" "$HOME/.local/bin/"; then
    echo -e >&2 "Failed to copy ${packageName} to $HOME/.local/bin.\n"
    exit 1
else
    echo -e "Copied ${packageName} to $HOME/.local/bin.\n"
fi

if ! install -m 644 "systemd/${systemdServiceName}" "$HOME/.config/systemd/user/"; then
    echo -e >&2 "Failed to copy ${systemdServiceName} to $HOME/.config/systemd/user.\n"
    exit 1
else
    echo "Copied ${systemdServiceName} to $HOME/.config/systemd/user.\n"
fi

if ! systemctl --user daemon-reload; then
    echo -e >&2 "Failed to reload systemd manager configuration.\n"
    exit 1
else
    echo -e "Reloaded systemd manager configuration.\n"
fi

if ! systemctl --user enable --now "${systemdServiceName}"; then
    echo -e >&2 "Failed to enable and start ${systemdServiceName}.\n"
    exit 1
else
    echo -e "Enabled and started ${systemdServiceName}.\n"
fi

echo -e "\n\tInstallation has successfully finished!\n"
