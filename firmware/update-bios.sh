#!/bin/bash

#Determine model number
model=$(sudo dmidecode -s system-version)

#Download boot.efi
wget https://raw.githubusercontent.com/comexr/firmware/main/firmware/boot.efi -O /tmp/boot.efi

#Get EC firmware
wget https://raw.githubusercontent.com/comexr/firmware/main/firmware/$model/firmware.rom -O /tmp/firmware.rom

#Move firmware files
sudo mkdir -p /boot/efi/firmware-update/firmware
sudo cp /tmp/boot.efi /boot/efi/firmware-update
sudo cp /tmp/ec.rom /boot/efi/firmware-update/firmware

#Flash EC
sudo efibootmgr --quiet --create --bootnum 1000 --disk /dev/nvme0n1 --part 1 --loader "\firmware-update\boot.efi" --label firmware-update
sudo shutdown 0

# After reboot:

#Determine model number
model=$(sudo dmidecode -s system-version)

#Download flashrom binary (+ make executable)
wget https://raw.githubusercontent.com/comexr/firmware/main/firmware/flashrom -O /tmp/flashrom
chmod +x /tmp/flashrom

#Get BIOS firmware
wget https://raw.githubusercontent.com/comexr/firmware/main/firmware/$model/ec.rom -O /tmp/ec.rom

#Flash BIOS
sudo /tmp/flashrom -p internal -w /tmp/firmware.rom