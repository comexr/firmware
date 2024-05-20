#!/bin/bash

#Determine model number
model=$(sudo dmidecode -s system-version)

#Download boot.efi
wget https://raw.githubusercontent.com/comexr/firmware/main/firmware/boot.efi -O /tmp/boot.efi

#Get EC firmware
wget https://raw.githubusercontent.com/comexr/firmware/main/firmware/$model/ec.rom -O /tmp/ec.rom

#Move firmware files
sudo mkdir -p /boot/efi/firmware-update/firmware
sudo cp /tmp/boot.efi /boot/efi/firmware-update
sudo cp /tmp/ec.rom /boot/efi/firmware-update/firmware

#Download ectool
wget https://raw.githubusercontent.com/comexr/firmware/main/firmware/ectool -O /tmp/ectool
sudo chmod +x /tmp/ectool

#Flash EC
sudo /tmp/ectool security unlock #Unlock BIOS
sudo efibootmgr --quiet --create --bootnum 1000 --disk /dev/nvme0n1 --part 1 --loader "\firmware-update\boot.efi" --label firmware-update
sudo shutdown 0

# Prepare post-reboot script
sudo tee -a /boot/efi/firmware-update/bios.sh > /dev/null  <<EOF
#Determine model number
model=$(sudo dmidecode -s system-version)

#Download flashrom binary (+ make executable)
wget https://raw.githubusercontent.com/comexr/firmware/main/firmware/flashrom -O /tmp/flashrom
chmod +x /tmp/flashrom

#Get BIOS firmware
wget https://raw.githubusercontent.com/comexr/firmware/main/firmware/$model/firmware.rom -O /tmp/firmware.rom

#Flash BIOS
sudo /tmp/flashrom -p internal -w /tmp/firmware.rom

#Clean up system
sudo sed -i '$d' /etc/crontab    #Remove cronjob
sudo rm -rf /boot/efi/firmware-update
EOF

#Create cronjob
echo "@reboot root bash /boot/efi/firmware-update/bios.sh" | sudo tee -a /etc/crontab