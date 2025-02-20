# AutoDnD 

A small Bash script that automatically disables and re-enables notifications when a window is in full screen mode on Hyprland.

## Installation

### Dependencies:
- hyprland
- socat
- swaync

### Installation script:

> [!WARNING]
> **Always** read and understand scripts before executing them!

```
curl -fsSL https://raw.githubusercontent.com/DHDcc/autodnd/refs/heads/main/install.sh | sh
```

### Manually install it:


#### 1) Clone the repo:

```
$ git clone https://github.com/DHDcc/autodnd.git
```
#### 2) Copy the files:

```
$ cd autodnd
$ chmod u+x src/autodnd
$ mkdir -p ~/.local/bin ~/.config/systemd/user
$ cp src/autodnd ~/.local/bin
$ cp systemd/autodnd.service ~/.config/systemd/user
```

#### 3.1) Enable and start the Systemd service:

```
$ systemctl --user daemon-reload
$ systemctl --user enable --now autodnd.service
```
OR

#### 3.2) Use ```exec-once``` in your ```hyprland.conf``` file:

```
exec-once = nohup ~/.local/bin/autodnd 0<&- &>/dev/null &
```

