#!/usr/bin/sh
set -eu

ESCALATE=${ESCALATE:-doas}
REPOSITORY="https://github.com/kbeerta/dotfiles"
DEPENDENCIES="stow zsh fzf" # missing neovim-git from AUR

INSTALL_DIR=${INSTALL_DIR:-$HOME/dotfiles}

info() {
    echo -e "\033[0;32m[INFO]\033[0m $*";
}

die() {
    error "Failed to install: $*";
    exit 1;
}

confirm() {
    printf "%s [y/n]: " "$1"
    read answer
    case "$answer" in
        y|Y) return 0;;
	*) return 1 ;;
    esac
}

if ! command -v git >/dev/null 2>&1; then
    die "git is not installed"
fi

if command -v pacman >/dev/null 2>&1 && confirm "Automatically install missing dependencies?"; then
    info "Checking dependencies";

    MISSING=""
    for cmd in $DEPENDENCIES; do
        command -v "$cmd" >/dev/null 2>&1 || MISSING="$MISSING $cmd"
    done

    if [ -n "$MISSING" ]; then
        info "Installing missing dependencies:$MISSING"
        $ESCALATE pacman -Sy --noconfirm $MISSING
    fi
fi

if [ -d "$INSTALL_DIR" ]; then
    info "$INSTALL_DIR is not empty"
    if ! confirm "Continue using files present in '$INSTALL_DIR'?"; then
        die "'$INSTALL_DIR' directory not empty"
    fi
else
    git clone --depth 1 --recurse-submodules --shallow-submodules $REPOSITORY $INSTALL_DIR
fi

if [ "${SHELL##*/}" != "zsh" ] && confirm "Set default shell to zsh?"; then
    NEW_SHELL="$(command -v zsh)"

    if [ -z "$NEW_SHELL" ]; then
	die "zsh is not installed"
    fi

    chsh -s "$NEW_SHELL"
    info "Set new \$SHELL to '$NEW_SHELL'"
fi

if [ -d "$INSTALL_DIR/.local/bin" ]; then
    find $INSTALL_DIR/.local/bin -maxdepth 1 -type f -exec chmod +x {} +
    info "Made scripts in '$INSTALL_DIR/.local/bin' executable"
fi

if confirm "Stow dotfiles to $HOME?"; then
    stow -d "$INSTALL_DIR" -t "$HOME" .
    info "Stowed dotfiles to '$HOME'"
fi

info "Done! Installed dotfiles to: $INSTALL_DIR!"
