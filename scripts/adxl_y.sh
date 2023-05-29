#!/bin/sh
NOW=$(date +"%Y_%m_%d_%I_%M_%p")
DIR="/home/agravelot/printer_data/config/input_shaper_history/${NOW}"

mkdir -p ${DIR}
~/klipper/scripts/calibrate_shaper.py /tmp/calibration_data_y_*.csv -o ${DIR}/shaper_calibrate_y_${NOW}.png
mv /tmp/calibration_data_y_*.csv ${DIR}