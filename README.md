# Coreboot firmware updating

To update the BIOS and EC firmware from Coreboot devices, follow the instructions below.

The following models are supported:
- NS50AU
- NS70AU
- L141AU
- PE60RNE

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

## First-time flashers (only for the L141AU)
If you have a L141AU and are going to flash it for the first time, you should first transition it, based on the keyboard layout. 
You only need to do this once. After the transition you can follow the generic instructions and use that script in the future.
The command to run for a L141AU with the ANSI keyboard layout is as follows:
```
curl https://raw.githubusercontent.com/comexr/firmware/main/firmware/transition_L141AU_ANSI.sh | bash
```

For the L141AU with the ISO keyboard layout the script below should be used:
```
curl https://raw.githubusercontent.com/comexr/firmware/main/firmware/transition_L141AU_ISO.sh | bash
```
