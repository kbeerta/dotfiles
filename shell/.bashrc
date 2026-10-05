export EDITOR=vi
export PS1="\w \$(_exit)"

eval "$(mise activate bash)"

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

_exit() {
	local code=$?
	if [ $code -ne 0 ]; then
		echo -e "\x1b[31m${code}\x1b[0m "
	else
		echo -e "\x1b[35m${code}\x1b[0m "
	fi
}
