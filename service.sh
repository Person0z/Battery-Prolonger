#!/system/bin/sh

# CPU core settings path
CPU_CORE_PATH="/sys/devices/system/cpu"

# Detect the number of cores dynamically
CPU_CORES=$(ls $CPU_CORE_PATH | grep -E 'cpu[0-9]+' | wc -l)
echo "Detected $CPU_CORES CPU cores"

# Default frequency values
LITTLE_MIN_FREQ=300000
LITTLE_MAX_FREQ=1200000
BIG_MIN_FREQ=600000
BIG_MAX_FREQ=1800000

# Apply settings to each core
for i in $(seq 0 $((CPU_CORES - 1))); do
    CPU_GOVERNOR_PATH="$CPU_CORE_PATH/cpu$i/cpufreq/scaling_governor"
    CPU_MIN_FREQ_PATH="$CPU_CORE_PATH/cpu$i/cpufreq/scaling_min_freq"
    CPU_MAX_FREQ_PATH="$CPU_CORE_PATH/cpu$i/cpufreq/scaling_max_freq"
    CPU_CLUSTER_PATH="$CPU_CORE_PATH/cpu$i/topology/physical_package_id"
    
    # Check if the CPU governor path exists
    if [ -f "$CPU_GOVERNOR_PATH" ]; then
        echo "powersave" > "$CPU_GOVERNOR_PATH"
        echo "Governor set to 'powersave' on CPU core $i"
    fi

    # Determine if the core belongs to LITTLE or BIG cluster
    if [ -f "$CPU_CLUSTER_PATH" ]; then
        CLUSTER_ID=$(cat $CPU_CLUSTER_PATH)
        if [ "$CLUSTER_ID" -eq 0 ]; then
            # LITTLE Core
            [ -f "$CPU_MIN_FREQ_PATH" ] && echo "$LITTLE_MIN_FREQ" > "$CPU_MIN_FREQ_PATH"
            [ -f "$CPU_MAX_FREQ_PATH" ] && echo "$LITTLE_MAX_FREQ" > "$CPU_MAX_FREQ_PATH"
            echo "Core $i (LITTLE): Min Freq = $LITTLE_MIN_FREQ, Max Freq = $LITTLE_MAX_FREQ"
        else
            # BIG Core
            [ -f "$CPU_MIN_FREQ_PATH" ] && echo "$BIG_MIN_FREQ" > "$CPU_MIN_FREQ_PATH"
            [ -f "$CPU_MAX_FREQ_PATH" ] && echo "$BIG_MAX_FREQ" > "$CPU_MAX_FREQ_PATH"
            echo "Core $i (BIG): Min Freq = $BIG_MIN_FREQ, Max Freq = $BIG_MAX_FREQ"
        fi
    else
        # Fallback if no cluster-info
        [ -f "$CPU_MIN_FREQ_PATH" ] && echo "$LITTLE_MIN_FREQ" > "$CPU_MIN_FREQ_PATH"
        [ -f "$CPU_MAX_FREQ_PATH" ] && echo "$BIG_MAX_FREQ" > "$CPU_MAX_FREQ_PATH"
        echo "Core $i (Fallback): Min Freq = $LITTLE_MIN_FREQ, Max Freq = $BIG_MAX_FREQ"
    fi
done

echo "CPU governor and frequency settings applied successfully."
