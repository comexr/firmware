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
