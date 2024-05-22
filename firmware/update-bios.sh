#!/bin/bash

if command -v apt >/dev/null 2>&1; then
  # Debian-gebaseerde distributies (Debian, Ubuntu)
  sudo apt install -y libhidapi-dev
elif command -v dnf >/dev/null 2>&1; then
  # Fedora
  sudo dnf install -y hidapi-devel
elif command -v zypper >/dev/null 2>&1; then
  # openSUSE
  sudo zypper install -y libhidapi-devel
elif command -v pacman >/dev/null 2>&1; then
  # Arch-gebaseerde distributies (Manjaro)
  sudo pacman --noconfirm -S hidapi
fi

#Determine model number
model=$(sudo dmidecode -s system-version)

#Create firmware update directory
sudo mkdir -p /opt/firmware-update

#Get firmware (BIOS and EC)
sudo wget https://raw.githubusercontent.com/comexr/firmware/main/firmware/$model/firmware.rom -O /opt/firmware-update/firmware.rom
sudo wget https://raw.githubusercontent.com/comexr/firmware/main/firmware/$model/ec.rom -O /opt/firmware-update/ec.rom

#Download ectool (+ make executable)
sudo wget https://raw.githubusercontent.com/comexr/firmware/main/firmware/ectool -O /opt/firmware-update/ectool
sudo chmod +x /opt/firmware-update/ectool

#Download flashrom binary (+ make executable)
sudo wget https://raw.githubusercontent.com/comexr/firmware/main/firmware/flashrom -O /opt/firmware-update/flashrom
sudo chmod +x /opt/firmware-update/flashrom

# Prepare post-reboot script
sudo tee -a /opt/firmware-update/bios.sh > /dev/null  <<EOF
#Flash BIOS
sudo /opt/firmware-update/flashrom -p internal -w /opt/firmware-update/firmware.rom

#Flash EC
sudo /opt/firmware-update/ectool flash /opt/firmware-update/ec.rom

#Clean up system
sudo sed -i '/firmware-update/d' /etc/crontab   #Remove cronjob
sudo rm -rf /opt/firmware-update
EOF

#Create cronjob
echo "@reboot root bash /opt/firmware-update/bios.sh" | sudo tee -a /etc/crontab

#Unlock BIOS
sudo /opt/firmware-update/ectool security unlock

#Start flashing
shutdown 0