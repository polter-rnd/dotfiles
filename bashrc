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
__ps1() {
    local undo_color="\[\e[m\]"
    local host_color="\[\e[38;5;153m\]"
    local user_color="\[\e[38;5;172m\]"
    if [ $EUID -eq 0 ]; then
        user_color="\[\e[0;31m\]"
    fi

    echo "[$user_color\u$undo_color@$host_color\h$undo_color \W]"
}

__git_ps1_venv() {
    # Some local storage to not clutter the environment
    local pre=$1
    local post=$2

    # Let's only check for a virtual environment if the VIRTUAL_ENV variable is
    # set. This should eek out a little more performance when we're not in one
    # since we won't need to call basename.
    if [ -n "${VIRTUAL_ENV}" ] && [ -z "${VIRTUAL_ENV_DISABLE_PROMPT:-}" ]; then
        # The python venv module hard-codes the name of the virtual environment into
        # the activate script for my configuration, so we need to pull it out of
        # VIRTUAL_ENV to have an appropriate prefix. If we're doing that, might has
        # well comment out the hard-coded part and rely on the else in the
        # if-statement that follows it.
        #
        #if [ "x(env) " != x ] ; then
        #    PS1="(env) ${PS1:-}"
        #else

        local venv_color="\[\e[38;5;127m\]"
        local undo_color="\[\e[m\]"

        # This is the else of the if-statement with PS1 replaced with pre.
        # Otherwise, no changes.
        if [ "`basename \"${VIRTUAL_ENV}\"`" = "__" ] ; then
            # special case for Aspen magic directories
            # see http://www.zetadev.com/software/aspen/
            pre="($venv_color`basename \`dirname \"${VIRTUAL_ENV}\"\``$undo_color) ${pre}"
        else
            pre="($venv_color`basename \"${VIRTUAL_ENV}\"`$undo_color) ${pre}"
        fi
    fi

    GIT_PS1_SHOWCOLORHINTS=true
    GIT_PS1_SHOWDIRTYSTATE=true
    GIT_PS1_SHOWUNTRACKEDFILES=true
    GIT_PS1_SHOWUPSTREAM="auto"

    # Call the actual __git_ps1 function with the modified arguments
    __git_ps1 "${pre}" "${post}"
}


source /run/host/usr/share/git-core/contrib/completion/git-prompt.sh 2>/dev/null
if command -v __git_ps1 > /dev/null; then
    # If __git_ps1 exist, add it to PROMPT_COMMAND
    PROMPT_COMMAND=${PROMPT_COMMAND:+"$PROMPT_COMMAND;"}
    PROMPT_COMMAND='__git_ps1_venv "`__ps1`" "\\\$ "'
else
    # Otherwise use plain PS1
    PS1="`__ps1`\\$ "
fi

alias mvn="bash $HOME/.local/opt/maven/bin/mvn"
