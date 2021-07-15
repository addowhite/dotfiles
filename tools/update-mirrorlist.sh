#!/bin/sh
reflector --protocol https --latest 70 --sort rate --save /etc/pacman.d/mirrorlist
