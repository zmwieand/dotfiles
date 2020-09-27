#!/bin/bash

CURRENT_CLUSTER=$(kubectl config current-context | cut -d/ -f2)

COLOR="#[fg=white,bold,bg=colour69] ⎈ "
DEFAULT="#[fg=green,bold,noblink,bg=colour237]"

# We can make the background red and blinking helm if a productino cluster
# if [[ ${CURRENT_CLUSTER} == "<cluster name>" ]]; then
#   COLOR="#[fg=white,bold,blink,bg=red] ⎈ #[fg=white,bold,noblink,bg=red]"

echo "${COLOR}${CURRENT_CLUSTER} ${DEFAULT}"
