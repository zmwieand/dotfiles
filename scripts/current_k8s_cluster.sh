#!/bin/bash

declare -a PRODUCTION_CLUSTERS=(
  "cronjobs-prod"
  "datahub-production"
  "production"
)

declare -a INTERNAL_PRODUCTION_CLUSTERS=(
  "jenkins"
  "vault"
  "internal-production"
)

CURRENT_CLUSTER=$(kubectl config current-context | cut -d/ -f2)
if [[ -z ${CURRENT_CLUSTER} ]]; then
  CURRENT_CLUSTER="-"
fi

COLOR="#[fg=white,bold,bg=colour69] ⎈ "
DEFAULT="#[fg=green,bold,noblink,bg=colour237]"

# We can make the background red and blinking helm if a production cluster
if [[ " ${PRODUCTION_CLUSTERS[@]} " =~ " ${CURRENT_CLUSTER} " ]]; then
  COLOR="#[fg=white,bold,blink,bg=red] ⎈ #[fg=white,bold,noblink,bg=red]"

# We can make the background orange and blinking helm if an internal production cluster
elif [[ " ${INTERNAL_PRODUCTION_CLUSTERS[@]} " =~ " ${CURRENT_CLUSTER} " ]]; then
  COLOR="#[fg=white,bold,blink,bg=colour196] ⎈ #[fg=white,bold,noblink,bg=colour196]"
fi

echo "${COLOR}${CURRENT_CLUSTER} ${DEFAULT}"
