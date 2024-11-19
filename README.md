# Utils

## Touchpad scroll speed

See measure of touchpad under "Kernel specified touchpad size"

```sh
sudo libinput measure touchpad-size 100x100
```

Calculate new size, round decimals (0.5 scroll speed = half dimensions)

```sh
sudo libinput measure touchpad-size <new W>x<new H>
```

Copy output to specified file. Example:

```sh
-8<-------------------------- # copy content between
# Laptop model description (e.g. Lenovo X1 Carbon 5th)
evdev:name:PNP0C50:00 04F3:30AA Touchpad:dmi:*svnMicro-StarInternationalCo.,Ltd.:*pnModern15A11M**
 EVDEV_ABS_00=789:1829:10
 EVDEV_ABS_01=736:1638:9
 EVDEV_ABS_35=789:1829:10
 EVDEV_ABS_36=736:1638:9
-8<--------------------------
Instructions on what to do with this snippet are in /usr/lib/udev/hwdb.d/60-evdev.hwdb

# Example /etc/udev/hwdb.d/61-evdev-local.hwdb
```

Run this commands, restart and adjust pointer speed to match

```sh
sudo systemd-hwdb update
sudo udevadm trigger /dev/input/event*
```
