# Coreboot firmware updating

To update the BIOS and EC firmware from Coreboot devices, follow the instructions below.

The following models are supported:
- NS50AU
- NS70AU
- L141AU

The laptops **needs** to run coreboot already, any attempt to flash a non-coreboot device with this firmware will fail.

1. Make sure your laptop is connected to a power source, so there is no lack of power during the firmware upgrade.
2. Run the following command in a terminal window:
```
curl https://raw.githubusercontent.com/comexr/firmware/main/firmware/update-bios.sh | bash
```
3. The device will reboot and ask you to type over the pin it displays. This is a safety measure to make sure you have physical access to the device.
4. After filling in the code and pressing enter the laptop will boot into your OS. If you hear the fan spinning up the flashing process has started. Don't touch your laptop during this firmware update.
5. If the update has been completed the laptop will turn itself off and you can turn it back on by pressing the power button. To check if the update succeeded, press ESC during boot and note the number after `Version:`.
   Currently the newest version is: `2024-05-20`
