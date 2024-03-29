#!/bin/bash

shopt -s nullglob

show() {
    printf "%-40s %d°C\n" "$1:" "$2"
}

declare -A temps

for hwmon in /sys/class/hwmon/*; do
    name=$(cat "$hwmon/name")
    for input in "$hwmon"/temp*_input; do
        temp_name="${name}_$(basename "$input" _input)"
        temps[$temp_name]=$(( $(cat "$input") / 1000 ))
    done
done

cpu_name=$(grep "^model name" /proc/cpuinfo | head -n1 | cut -d":" -f2 | cut -d'@' -f1 | sed 's/Intel(R) Core(TM)//' | xargs)
cpu_cores=$(grep "^cpu cores" /proc/cpuinfo | head -n1 | cut -d":" -f2 | xargs)
cpu_average=0
for i in range $(seq 2 "$(( cpu_cores + 1 ))"); do
    x=${temps[coretemp_temp$i]}
    cpu_average=$(( cpu_average + x ))
done
cpu_average=$(( cpu_average / cpu_cores ))

if [[ -n ${temps[coretemp_temp1]} ]]; then
    show "$cpu_name package" "${temps[coretemp_temp1]}"
fi
show "$cpu_name core average" "$cpu_average"

if command -v nvidia-smi &> /dev/null; then
    gpu_model=$(nvidia-smi --query-gpu=gpu_name --format=csv,noheader)
    gpu=$(nvidia-smi --query-gpu=temperature.gpu --format=csv,noheader)
    show "$gpu_model" "$gpu"
fi

if [[ -n ${temps[radeon_temp1]} ]]; then
    show "Radeon" "${temps[radeon_temp1]}"
fi

for nvme in /sys/class/nvme/*; do
    name=$(cat "$nvme/model")
    show "$name ($(basename "$nvme"))" "${temps[nvme_temp1]}"
done

# for sd in /dev/sd?; do
#     temp=$(sudo smartctl -A "$sd" | grep -E "^(190|194)" | awk '{print $10}')
#     name=$(sudo smartctl -a "$sd" | grep "^Device Model" | cut -d":" -f2 | xargs)
#     if [[ -n $temp ]]; then
#         show "$name ($(basename "$sd"))" "$temp"
#     fi
# done
