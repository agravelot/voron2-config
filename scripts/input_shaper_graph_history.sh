#!/bin/bash


NOW=$(date +"%Y_%m_%d_%I_%M_%p")
DIR="/home/agravelot/printer_data/config/input_shaper_history/${NOW}"

X_FILES=$(/tmp/calibration_data_x_*.csv)
Y_FILES=$(/tmp/calibration_data_y_*.csv)

if [[ ! -f "$X_FILES" && ! -f "$Y_FILES" ]]
then 
	echo "No matching csv calibration files avialable."
	exit 1
fi

if [[ -f "$X_FILES" ]]
then
	~/klipper/scripts/calibrate_shaper.py /tmp/calibration_data_x_*.csv -o ${DIR}/shaper_calibrate_x_${NOW}.png
	mv /tmp/calibration_data_x_*.csv ${DIR}
fi

if [[ -f "$Y_FILES" ]]
then
        ~/klipper/scripts/calibrate_shaper.py /tmp/calibration_data_y_*.csv -o ${DIR}/shaper_calibrate_y_${NOW}.png
        mv /tmp/calibration_data_y_*.csv ${DIR}
fi
