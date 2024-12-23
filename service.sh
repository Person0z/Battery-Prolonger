#!/system/bin/sh

# Detect CPU core count
CPU_CORE_PATH="/sys/devices/system/cpu"
CPU_CORES=$(ls $CPU_CORE_PATH | grep -E 'cpu[0-9]+' | wc -l)

# Log detected core count
echo "Detected $CPU_CORES CPU cores"

# Apply powersave governor to each core
for i in $(seq 0 $((CPU_CORES - 1))); do
    CPU_GOVERNOR_PATH="$CPU_CORE_PATH/cpu$i/cpufreq/scaling_governor"
    
    if [ -f "$CPU_GOVERNOR_PATH" ]; then
        echo "powersave" > "$CPU_GOVERNOR_PATH"
        echo "Set governor to powersave on CPU core $i"
    else
        echo "Governor path for CPU core $i not found, skipping..."
    fi
done

# Log completion
echo "All detected cores set to powersave governor."
