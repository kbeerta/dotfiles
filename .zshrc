setopt PROMPT_SUBST

git_dirty() {
    (( $+commands[git] )) || return 0

    git rev-parse --is-inside-work-tree &>/dev/null || return

    if [[ -n $(git status --porcelain 2>/dev/null) ]]; then
        echo "%F{yellow}*%f"
    fi
}

export PROMPT='%(?..%F{red}%?%f )${CONTAINER_ID:+"%F{magenta}[$CONTAINER_ID]%f "}%~$(git_dirty) # '
export RPROMPT='$(cat /sys/class/power_supply/BAT0/capacity)%%'

alias emacs='emacs --no-window'
