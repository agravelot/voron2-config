#!/bin/bash

PWD="$PWD"


sudo service klipper stop
cd ~/klipper
#git pull

# Octopus
make clean KCONFIG_CONFIG=$PWD/octopus.config
#make menuconfig KCONFIG_CONFIG=$PWD/octopus.config
make KCONFIG_CONFIG=$PWD/octopus.config
read -p "Octopus firmware built, please check above for any errors. Press [Enter] to continue flashing, or [Ctrl+C] to abort"

#make KCONFIG_CONFIG=config.octopus flash FLASH_DEVICE=/dev/serial/by-id/YourMCUIDHere
#./scripts/flash-sdcard.sh /dev/ttyAMA0 fysetc-spider-v1
read -p "Octopus firmware flashed, please check above for any errors. Press [Enter] to continue, or [Ctrl+C] to abort"


# Rpi
make clean KCONFIG_CONFIG=$PWD/config.rpi
#make menuconfig KCONFIG_CONFIG=$PWD/config.rpi

make KCONFIG_CONFIG=$PWD/config.rpi
read -p "RPi firmware built, please check above for any errors. Press [Enter] to continue flashing, or [Ctrl+C] to abort"
#make flash KCONFIG_CONFIG=$PWD/config.rpi
read -p "RPi firmware flashed, please check above for any errors. Press [Enter] to continue, or [Ctrl+C] to abort"

# SB2240

#make clean KCONFIG_CONFIG=$PWD/sb2240.config
#make menuconfig KCONFIG_CONFIG=$PWD/sb2240.config
#make KCONFIG_CONFIG=$PWD/sb2240.config
#read -p "SB2240 firmware built, please check above for any errors. Press [Enter] to continue flashing, or [Ctrl+C] to abort"

#python3 ~/katapult/scripts/flash_can.py -i can0 -u YourCANBUSUUIDHere -r
#python3 ~/katapult/scripts/flash_can.py -i can0 -u YourCANBUSUUIDHere -f ~/klipper/out/klipper.bin
#read -p "SB2240 firmware flashed, please check above for any errors. Press [Enter] to continue, or [Ctrl+C] to abort"


# sht36 v2

#make clean KCONFIG_CONFIG=$PWD/sh36v2.config
#make menuconfig KCONFIG_CONFIG=$PWD/sht36v2.config
#make KCONFIG_CONFIG=$PWD/sht36v2.config
#read -p "sht36v2 firmware built, please check above for any errors. Press [Enter] to continue flashing, or [Ctrl+C] to abort"

#python3 ~/katapult/scripts/flash_can.py -i can0 -u YourCANBUSUUIDHere -r
#python3 ~/katapult/scripts/flash_can.py -i can0 -u YourCANBUSUUIDHere -f ~/klipper/out/klipper.bin
#read -p "sht36v2 firmware flashed, please check above for any errors. Press [Enter] to continue, or [Ctrl+C] to abort"

sudo service klipper start
