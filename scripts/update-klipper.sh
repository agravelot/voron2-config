#!/bin/bash

set -xe  # Exit on error and print commands

DIR=~/printer_data/config/scripts
KLIPPER_DIR=~/klipper
KLIPPER_SCRIPTS="$KLIPPER_DIR/scripts"
KATAPULT_SCRIPTS=~/katapult/scripts


RUN_MENUCONFIG=false  # Default: do not run menuconfig

# Check for --menuconfig argument
if [[ "$1" == "--menuconfig" ]]; then
    RUN_MENUCONFIG=true
fi

stop_klipper() {
    sudo service klipper stop
}

start_klipper() {
    sudo service klipper start
}

build() {
    local config_file="$1"

    echo "Building firmware for $config_file"
    cd $KLIPPER_DIR
    env KCONFIG_CONFIG="$config_file" make clean

    if $RUN_MENUCONFIG; then
        env KCONFIG_CONFIG="$config_file" make menuconfig 
    fi

    #env KCONFIG_CONFIG=/home/agravelot/printer_data/config/scripts/octopus.config make -j"$(nproc)"
    env KCONFIG_CONFIG="$config_file" make -j"$(nproc)"
}

flash_usb() {
    local config_file="$1"
    local flash_device="$2"

    echo "Flashing firmware for $config_file"
    cd $KLIPPER_DIR

    env KCONFIG_CONFIG="$config_file" make flash FLASH_DEVICE="$flash_device"
}

flash_can() {
    local config_file="$1"
    local unique_id="$2"

    echo "Flashing firmware for $config_file via CAN bus"
    cd $KLIPPER_DIR

    python3 "$KATAPULT_SCRIPTS/flash_can.py" -i can0 -u "$unique_id" -r
    python3 "$KATAPULT_SCRIPTS/flash_can.py" -i can0 -u "$unique_id" -f "$KLIPPER_DIR/out/klipper.bin"
}

enter_bootloader() {
    local device_path="$1"
    cd $KLIPPER_SCRIPTS

    echo "Rebooting device into bootloader: $device_path"
    python3 -c "import flash_usb as u; u.enter_bootloader(\"$device_path\")"
    cd -
}

# Main script execution
stop_klipper

# Octopus
#enter_bootloader "/dev/serial/by-id/usb-Klipper_stm32f446xx_280020001551313133353932-if00"
#build "$DIR/octopus.config"
#flash_usb "$DIR/octopus.config" "/dev/serial/by-id/usb-katapult_stm32f446xx_280020001551313133353932-if00"

# Octopus Pro
enter_bootloader "/dev/serial/by-id/usb-Klipper_stm32f446xx_290020000450534E4E313020-if00"
build "$DIR/octopus.config"
flash_usb "$DIR/octopus.config" "/dev/serial/by-id/usb-katapult_stm32f446xx_290020000450534E4E313020-if00"

# LIS2DW (uncomment to enable)
# enter_bootloader "/dev/serial/by-id/usb-Klipper_rp2040_btt_acc-if00"
# build_and_flash_usb "$DIR/lis2dw.config" "2e8a:0003"

# RPi
build "$DIR/rpi.config"
flash_usb "$DIR/rpi.config"

# SB2240 (uncomment to enable)
# build "$DIR/sb2240.config" "de2f42d3cb5a"
# flash_can "$DIR/sb2240.config" "de2f42d3cb5a"

# sht36v2
build "$DIR/sht36v2.config" "05888914ca52"
flash_can "$DIR/sht36v2.config" "05888914ca52"

start_klipper
