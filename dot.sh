#!/bin/bash

if ! command -v stow &> /dev/null; then
    echo "GNU Stow is not installed!"
    exit 1
fi

stow_config() {
    local config="$1"
    
    if stow "$config" 2> /dev/null; then
        echo "✓ Stowed $config"
    else
        echo "⚠ Failed to stow $config, attempting restow..."
        if stow --restow "$config" 2> /dev/null; then
            echo "✓ Restowed $config"
        else
            echo "✗ Failed to stow $config"
        fi
    fi
}

unstow_config() {
    local config="$1"
    
    if stow --delete "$config" 2> /dev/null; then
        echo "✓ Unstowed $config"
    else
        echo "✗ Failed to unstow $config"
    fi
}

if [[ $# -eq 0 ]]; then
    echo "Usage: $0 <stow|unstow>"
    exit 1
fi

action="$1"
shift

case "$action" in
    stow)
        if [[ $# -eq 0 ]]; then
            echo "Stowing all configs..."
            for dir in */; do
                dir="${dir%/}"
                if [[ "$dir" != ".git" ]]; then
                    stow_config "$dir"
                fi
            done
        else
            for config in "$@"; do
                stow_config "$config"
            done
        fi
        ;;
    unstow)
        if [[ $# -eq 0 ]]; then
            echo "Unstowing all configs..."
            for dir in */; do
                dir="${dir%/}"
                if [[ "$dir" != ".git" ]]; then
                    unstow_config "$dir"
                fi
            done
        else
            for config in "$@"; do
                unstow_config "$config"
            done
        fi
        ;;
    *)
        exit 1
        ;;
esac
