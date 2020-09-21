current_charge=$(pmset -g batt | grep -o '[0-9]\+%' | awk '{sub (/%/, "", $1); print $1}')
color="#[fg=green,bold]"
default="#[fg=green,bold]"

if [[ $current_charge -lt 15 ]]; then
    color="#[fg=red]"
elif [[ $current_charge -lt 40 ]]; then
    color="#[fg=yellow,bold]"
fi

echo "$color[$current_charge%]$default"
