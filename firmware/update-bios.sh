#!/bin/bash

#Determine model number
model=$(sudo dmidecode -s system-version)

#Download flashrom binary
wget https://raw.githubusercontent.com/comexr/firmware/main/firmware/flashrom -O /tmp/flashrom
chmod +x /tmp/flashrom

#Download boot.efi
wget https://raw.githubusercontent.com/comexr/firmware/main/firmware/boot.efi /tmp/boot.efi

#Get firmware for this model
wget https://raw.githubusercontent.com/comexr/firmware/main/firmware/$model/firmware.rom -O /tmp/firmware.rom
wget https://raw.githubusercontent.com/comexr/firmware/main/firmware/$model/ec.rom -O /tmp/ec.rom

#Create and copy to folder
sudo mkdir -p /boot/efi/firmware-update/firmware
sudo cp /tmp/boot.efi /tmp/firmware.rom /tmp/ec.rom /boot/efi/firmware-update/firmware

#Flash firmware
#sudo /tmp/flashrom -p internal -w /tmp/firmware.rom
#sudo /tmp/flashrom -p ite_ec:boardmismatch=force -w /tmp/ec.rom

#Reboot to apply
#sudo reboot