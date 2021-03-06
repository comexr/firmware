#!/bin/bash

#Update Coreboot Firmware utility
DMI_MODEL="$(cat /sys/class/dmi/id/product_version)"
#Catch for no option
if [[ $# -eq 0 ]]; then
    echo "This utility is used to update Laptop with Linux coreboot Firmware"
    echo "Please only use this utility when coreboot is already installed on your machine."
    echo " "
    echo "coreboot-updater [options]"
    echo " "
    echo "options:"
    echo "-h, --help                show this help message"
    echo "-u, --update              update firmware to next available firmware version"
    echo ""
    echo "When no flags are passed, this help message will be displayed"
    exit 0
else
    case "$1" in
    -h|--help)
    	echo "This utility is used to update Laptop with Linux coreboot Firmware"
    	echo "Please only use this utility when coreboot is already installed on your machine."
    	echo " "
    	echo "coreboot-updater [options]"
    	echo " "
    	echo "options:"
    	echo "-h, --help                show this help message"
    	echo "-u, --update              update firmware to next available firmware version"
    	echo ""
    	echo "When no flags are passed, this help message will be displayed"
      	exit 0
      	;;
    -u|--update)
      	echo "starting update..."
      	rom_foler=/usr/share/coreboot-updater/rom
      	spi_folder=/usr/share/coreboot-updater/libs/intel-spi
	wget -O /tmp/firmware_$DMI_MODEL.rom https://github.com/comexr/firmware/raw/main/models/"$DMI_MODEL"/firmware.rom &>/dev/null || { echo "Model not found, please contact support"; rm /tmp/firmware_$DMI_MODEL.rom; exit 1; }
	[ $? -ne 0 ] && { echo "Something went wrong, aborting"; exit 1; }
	diff /tmp/firmware_$DMI_MODEL.rom "$rom_folder"/firmware_$DMI_MODEL.rom
	if [ $? -eq 0 ]; then
		echo "Firmware already up to date!"
		echo "Stopping update"
		exit 0
	else
		mv /tmp/firmware_$DMI_MODEL.rom "$rom_foler"/firmware_$DMI_MODEL.rom
		echo "Newer version available!"
		echo "Starting flash"
	fi
	#Check if AC adapter is connected
	if [ "$(cat /sys/class/power_supply/BAT0/status)" == "Discharging" ]; then
   		echo "Please connect your AC adapter before attempting a firmware update"
   		exit 1
	fi
	
	sudo chmod +x "$spi_folder"/target/release/intel-spi
	sudo "$spi_folder"/target/release/intel-spi "$rom_folder/firmware_$DMI_MODEL.rom"
	echo "Firmware updated!"
	echo "Please reboot your system"
	exit 0
      	;;
    *)
      	break
      	;;
  esac
fi
exit 0



