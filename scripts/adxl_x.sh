#!/bin/sh

~/klipper/scripts/calibrate_shaper.py /tmp/calibration_data_x_*.csv -o ~/printer_data/config/input_shaper_history/shaper_calibrate_x_$(date +"%Y_%m_%d_%I_%M_%p").png
mv /tmp/calibration_data_x_*.csv ~/printer_data/config/input_shaper_history/