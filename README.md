# AutoDnD 

A small Bash script that automatically disables and re-enables notifications when a window is in full screen mode on Hyprland.

## install

Supported notification demons:

- [swaync](https://github.com/ErikReider/SwayNotificationCenter)

### Option 1: Use the installation script.

#### 1) Clone the repo:
```
$ git clone https://github.com/DHDcc/autodnd.git
```
#### 2) Run the installation script:
```
$ cd autodnd
$ chmod u+x install.sh
$ ./install.sh
```
### Option 2: Do it manually.


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
#### 3.2.1) logout and re-login:

```
$ hyprctl dispatch exit 0
$ uwsm stop # for uwsm users
```


