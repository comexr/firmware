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
fi

while test $# -gt 0; do
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
	break
      	;;
    *)
      	break
      	;;
  esac
done

wget -O /usr/share/coreboot-updater/firmware_"$DMI_MODEL".rom https://github.com/comexr/firmware/raw/main/models/"$DMI_MODEL"/firmware.rom &>/dev/null
[ $? -ne 0 ] && (echo "Something went wrong, aborting"; exit 1)

#Check if AC adapter is connected
if [ "$(cat /sys/class/power_supply/BAT0/status)" == "Discharging" ]
then
   echo "Please connect your AC adapter before attempting a firmware update"
   exit 1
fi

sudo chmod +x /usr/share/coreboot-updater/libs/intel-spi/target/release/intel-spi
sudo /usr/share/coreboot-updater/libs/intel-spi/target/release/intel-spi "/usr/share/coreboot-updater/firmware_$DMI_MODEL.rom"

