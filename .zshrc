setopt PROMPT_SUBST

export PROMPT='%(?..%F{red}%?%f )% ${CONTAINER_ID:+"%F{magenta}[$CONTAINER_ID]%f "}%~ # '
export RPROMPT='$(cat /sys/class/power_supply/BAT0/capacity)%%'
