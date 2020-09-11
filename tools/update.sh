#!/bin/sh

#HOME=/home/addo
#DISPLAY=:0
#XAUTHORITY=/home/addo/.Xauthority
#DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus

sudo -u addo HOME=/home/addo DISPLAY=:0 XAUTHORITY=/home/addo/.Xauthority DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus notify-send 'System Update' 'Starting update...' \
    --urgency=normal \
    --icon=dialog-information \
    -h string:x-canonical-private-synchronous:system-update \
  && pacman -Syyu \
  && sudo -u addo HOME=/home/addo DISPLAY=:0 XAUTHORITY=/home/addo/.Xauthority DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus notify-send 'System Update' 'Packages up-to-date.' \
    --urgency=normal \
    --icon=dialog-information \
    -h string:x-canonical-private-synchronous:system-update

sudo -u addo HOME=/home/addo DISPLAY=:0 XAUTHORITY=/home/addo/.Xauthority DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus notify-send 'System Update' 'Removing orphaned packages...' \
    --urgency=normal \
    --icon=dialog-information \
    -h string:x-canonical-private-synchronous:system-orphans \
  && pacman -Rns $(pacman -Qtdq)

sudo -u addo HOME=/home/addo DISPLAY=:0 XAUTHORITY=/home/addo/.Xauthority DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus notify-send 'System Update' 'Update complete.' \
    --urgency=normal \
    --icon=dialog-information \
    -h string:x-canonical-private-synchronous:system-orphans
