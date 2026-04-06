for file in "$ZDOTDIR/.zsh_prompt" "$ZDOTDIR/.zsh_aliases"; do
    [[ -f "$file" ]] && source $file
done

autoload -U compinit
fpath=("$ZDOTDIR/plugins/zsh-completions/src" $fpath)
rm -rf "$HOME/.cache/zsh/.zcompdump"; compinit -d "$HOME/.cache/zsh/.zcompdump"

ZSH_AUTOSUGGEST_STRATEGY=(history completion)
source "$ZDOTDIR/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh"

source "$ZDOTDIR/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
