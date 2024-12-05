#!/bin/bash

set -xe

DIR="$(pwd)"


sudo service klipper stop
cd ~/klipper
#git pull


# Octopus
# reboot in bootloader
cd ~/klipper/scripts
python3 -c 'import flash_usb as u; u.enter_bootloader("/dev/serial/by-id/usb-Klipper_stm32f446xx_280020001551313133353932-if00")'
cd -
echo $DIR/octopus.config
make clean KCONFIG_CONFIG=$DIR/octopus.config
#make menuconfig KCONFIG_CONFIG=$DIR/octopus.config
make KCONFIG_CONFIG=$DIR/octopus.config -j$(nproc)
#read -p "Octopus firmware built, please check above for any errors. Press [Enter] to continue flashing, or [Ctrl+C] to abort"

make KCONFIG_CONFIG=$DIR/octopus.config flash FLASH_DEVICE=/dev/serial/by-id/usb-katapult_stm32f446xx_280020001551313133353932-if00
#read -p "Octopus firmware flashed, please check above for any errors. Press [Enter] to continue, or [Ctrl+C] to abort"

# LIS2DW

# reboot in bootloader
#cd ~/klipper/scripts
#python3 -c 'import flash_usb as u; u.enter_bootloader("/dev/serial/by-id/usb-Klipper_rp2040_btt_acc-if00")'
#cd -

#echo $DIR/lis2dw.config
#make clean KCONFIG_CONFIG=$DIR/lis2dw.config
#make menuconfig KCONFIG_CONFIG=$DIR/lis2dw.config
#make KCONFIG_CONFIG=$DIR/lis2dw.config -j$(nproc)
##read -p "LIS2DW firmware built, please check above for any errors. Press [Enter] to continue flashing, or [Ctrl+C] to abort"

#make KCONFIG_CONFIG=$DIR/lis2dw.config flash FLASH_DEVICE=2e8a:0003
##read -p "LIS2DW firmware flashed, please check above for any errors. Press [Enter] to continue, or [Ctrl+C] to abort"


# Rpi
make clean KCONFIG_CONFIG=$DIR/rpi.config
#make menuconfig KCONFIG_CONFIG=$DIR/rpi.config

make KCONFIG_CONFIG=$DIR/rpi.config -j$(nproc)
#read -p "RPi firmware built, please check above for any errors. Press [Enter] to continue flashing, or [Ctrl+C] to abort"
make flash KCONFIG_CONFIG=$DIR/rpi.config
#read -p "RPi firmware flashed, please check above for any errors. Press [Enter] to continue, or [Ctrl+C] to abort"

# SB2240

#make clean KCONFIG_CONFIG=$DIR/sb2240.config
#make menuconfig KCONFIG_CONFIG=$DIR/sb2240.config
#make KCONFIG_CONFIG=$DIR/sb2240.config -j$(nproc)
#read -p "SB2240 firmware built, please check above for any errors. Press [Enter] to continue flashing, or [Ctrl+C] to abort"

#python3 ~/katapult/scripts/flash_can.py -i can0 -u de2f42d3cb5a -r
#python3 ~/katapult/scripts/flash_can.py -i can0 -u de2f42d3cb5a -f ~/klipper/out/klipper.bin
#read -p "SB2240 firmware flashed, please check above for any errors. Press [Enter] to continue, or [Ctrl+C] to abort"


# sht36 v2

make clean KCONFIG_CONFIG=$DIR/sh36v2.config
#make menuconfig KCONFIG_CONFIG=$DIR/sht36v2.config
make KCONFIG_CONFIG=$DIR/sht36v2.config -j$(nproc)
#read -p "sht36v2 firmware built, please check above for any errors. Press [Enter] to continue flashing, or [Ctrl+C] to abort"

python3 ~/katapult/scripts/flash_can.py -i can0 -u 05888914ca52 -r
python3 ~/katapult/scripts/flash_can.py -i can0 -u 05888914ca52 -f ~/klipper/out/klipper.bin
#read -p "sht36v2 firmware flashed, please check above for any errors. Press [Enter] to continue, or [Ctrl+C] to abort"

sudo service klipper start
