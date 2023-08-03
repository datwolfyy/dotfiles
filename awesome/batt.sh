#!/bin/sh
batt_time=$(sysctl -n hw.acpi.battery.time)
str="$(sysctl -n hw.acpi.battery.life)%"

[ $batt_time -eq -1 ] && str="$str [charging]"
echo ${str}
