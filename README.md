# Raspberry Pi AC Control

Quick script and config to control a Delonghi air conditioner with a Raspberry Pi via the IR remote.

## Setup

1. Install `lircd` if not already.
2. Edit `/boot/config.txt`:
  - Uncomment `dtoverlay=gpio-ir-tx,gpio_pin=18` for transmission.
  - Uncomment `dtoverlay=gpio-ir, gpio_pin=17` for receiving.

## Transmission

Use an LED to transmit to the device.  An IR LED is ideal, but a red one works fine at close range.

1. Connect LED between GPIO 18 and ground with a 220 Ohm resistor in series. 
2. Copy `delonghi.lircd.conf` to `/etc/lirc/lircd.conf.d/`
3. Reboot the pi
4. Run `irsend SEND_ONCE delonghi {command goes here}` using one of these commands:
  - POWER_ON
  - POWER_OFF
  - CHANGE_UNIT
  - INCREASE_TEMP
  - DECREASE_TEMP
  - FAN_SPEED

These commands are listed in the raw_codes section of the config.

## Recording

You can record commands using an IR receiver and a remote control.

1. Connect an IR receiver to 3v3, GND, and GPIO 17
2. Run `sudo mode2 -m -d /dev/lirc1 >  out.conf`
3. Push the remote buttons you want to save
4. Break the recording with `ctrl-c`.
5. Copy the raw values from `out.conf` to a new entry in the raw_codes section of an lircd config.
  - See this config as an example.