# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]
then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
HOST_COLOR="\[\e[38;5;153m\]"
if [[ $EUID -ne 0 ]]; then
    USER_COLOR="\[\e[38;5;172m\]"
else
    USER_COLOR="\[\e[0;31m\]"
fi

PS1="[$USER_COLOR\u\[\e[m\]@$HOST_COLOR\h\[\e[m\] \W]\\$ "

unset USER_COLOR HOST_COLOR

if [ -f /usr/share/git-core/contrib/completion/git-prompt.sh ]; then
    source /usr/share/git-core/contrib/completion/git-prompt.sh
    source /etc/profile.d/vte.sh

    GIT_PS1_SHOWCOLORHINTS=true
    GIT_PS1_SHOWDIRTYSTATE=true
    GIT_PS1_SHOWUNTRACKEDFILES=true
    GIT_PS1_SHOWUPSTREAM="auto"

    PROMPT_COMMAND="$(sed -r 's|^(.+)(\\\$\s*)$|__git_ps1 \"\1\" \"\\\2\"|' <<< $PS1)"

    if command -v __vte_prompt_command > /dev/null; then
        PROMPT_COMMAND="__vte_prompt_command;$PROMPT_COMMAND"
    fi
fi

alias mvn="bash /opt/idea/plugins/maven/lib/maven3/bin/mvn"
