#!/usr/bin/sh
set -eu

ESCALATE=${ESCALATE:doas}
REPOSITORY="https://github.com/kbeerta/dotfiles"
DEPENDENCIES="stow zsh neovim"

INSTALL_DIR="$HOME/dotfiles"

info() {
    echo -e "\033[0;32m][INFO]\033[0m $*";
}

die() {
    error "Failed to install: $*";
    exit 1; 
}

confirm() {
    printf "%s [y/n]: " "$1";
    case "$answer" in 
        y|Y) return 0;;
	*) return 1 ;;
    esac
}

if [ ! command -v git >/dev/null 2>&1 ]; then
    die "git is not installed"
fi


if [ command -v pacman >/dev/null 2>&1 ] && [ confirm "Automatically install missing dependencies?"]; then
    info "Checking dependencies";

    MISSING=""
    for cmd in $DEPENDENCIES; do
        command -v "$cmd" >/dev/null 2>&1 || MISSING="$MISSING $cmd"
    done

    if [ -n "$MISSING" ]; then
        info "Installing missing dependencies:$MISSING"
        $ESCALATE pacman -Sy --noconfirm $MISSING
    end
fi

git clone --depth 1 --recurse-submodules --shallow-submodules $REPOSITORY $INSTALL_DIR

if [ confirm "Set default shell to zsh?" ]; then
    NEW_SHELL = "$(command -v zsh)"

    if [ -z "$NEW_SHELL" ]; then
	die "zsh is not installed"
    fi

    chsh -s "$NEW_SHELL"
    info "Set new \$SHELL to '$NEW_SHELL'"
fi

if [ confirm "Stow dotfiles to $HOME?" ]; then
    stow -d "$INSTALL_DIR" -t "$HOME" .
    info "Stowed dotfiles to '$HOME'"
fi

info "Done! Installed dotfiles to: $INSTALL_DIR!"
