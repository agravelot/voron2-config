#!/usr/bin/bash

NOW="$(date +%Y%m%d_%H%M%S)"
DIR=~/printer_data/config/input_shaper_history/${NOW}
ALL_FILES=($(find /tmp -type f -readable -name "*.csv"))

if [[ -z "$ALL_FILES" ]]
then
	echo "No matching csv calibration files avialable."
	exit 1
fi

if [[ ! -d "$DIR" ]]
then
    mkdir -p "$DIR"
fi

for i in "${ALL_FILES[@]}"
do
	echo "Processing: $i"
	# https://github.com/Frix-x/klippain/blob/67f6bb91b8e54ef516c7c6e724abe913f7c41dbb/scripts/plot_graphs.sh
	# graph_accelerometer -> A/b
	# graph_vibrations -> vibrations
	~/klipper/scripts/calibrate_shaper.py "$i" -o ${DIR}/${i##*/}${NOW}.png
	mv "$i" ${DIR}
done
