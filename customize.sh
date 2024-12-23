#!/system/bin/sh

# Detect CPU core count
CPU_CORE_PATH="/sys/devices/system/cpu"
CPU_CORES=$(ls $CPU_CORE_PATH | grep -E 'cpu[0-9]+' | wc -l)

# Log detected core count
echo "Detected $CPU_CORES CPU cores"

ui_print "Setting permissions for service.sh..."
set_perm $MODPATH/service.sh 0 0 0755

ui_print "CPU Powersave Module Installed Successfully."
