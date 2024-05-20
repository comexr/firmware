#!/bin/bash

#Determine model number
model=$(sudo dmidecode -s system-version)

#Download flashrom binary
wget https://raw.githubusercontent.com/comexr/firmware/main/firmware/flashrom -O /tmp/flashrom
chmod +x /tmp/flashrom

#Download boot.efi


#Get firmware for this model
wget https://raw.githubusercontent.com/comexr/firmware/main/firmware/$model/firmware.rom -O /tmp/firmware.rom
wget https://raw.githubusercontent.com/comexr/firmware/main/firmware/$model/ec.rom -O /tmp/ec.rom

#Flash firmware
sudo /tmp/flashrom -p internal -w /tmp/firmware.rom
sudo /tmp/flashrom -p ite_ec:boardmismatch=force -w /tmp/ec.rom

#Reboot to apply
#sudo reboot