setopt PROMPT_SUBST

export PROMPT='${CONTAINER_ID:+"%F{magenta}[$CONTAINER_ID]%f "}%(?..%F{red}%?%f )%~ # '
