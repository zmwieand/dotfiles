#!/bin/bash

COLOR="#[fg=white,bold,bg=green]"
DEFAULT="#[fg=green,bold,bg=colour237]"

CURRENT_BATT=$(pmset -g batt | grep -Eo "[0-9]+%" | sed "s/%//g")

if [[ ${CURRENT_BATT} -lt 20 ]]; then
  COLOR="#[fg=white,bold,bg=red]"
elif [[ ${CURRENT_BATT} -lt 50 ]];then
  COLOR="#[fg=white,bold,bg=yellow]"
fi

echo "${COLOR} ϟ ${CURRENT_BATT}% ${DEFAULT}"
