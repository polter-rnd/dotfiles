__set_ps1_clean() {
	local undo_color="\[\e[m\]"
	local host_color="\[\e[38;5;153m\]"
	local user_color="\[\e[0;33m\]"
	if [ $EUID -eq 0 ]; then
		user_color="\[\e[0;31m\]"
	fi

	PS1="[$user_color\u$undo_color@$host_color\h$undo_color \W]"
}

__set_ps1_git_status() {
	local dir=$PWD
	while [ ! -d "$dir/.git" ]; do
		[ "$dir" != "" ] || return
		dir="${dir%/*}"
	done

	local line
	local modified
	local staged
	local untracked
	local conflict
	local branch
	local oid
	local ab
	while read -r line; do
		case "$line" in
		"1 .M"*) ;&
		"1 MM"*) ;&
		"2 .M"*) ;&
		"2 MM"*) modified="*" ;;
		"1 "*) ;&
		"2 "*) staged="+" ;;
		"u "*) conflict="!" ;;
		"? "*) untracked="%" ;;
		"# branch.head "*) branch=${line#\# branch.head } ;;
		"# branch.oid "*) oid=${line#\# branch.oid } ;;
		"# branch.ab "*) ab=${line#\# branch.ab } ;;
		esac
	done < <(git status -b --porcelain=v2 2>/dev/null)

	local red_color="\[\e[0;31m\]"
	local green_color="\[\e[0;32m\]"
	local undo_color="\[\e[m\]"

	local commit
	if [ "$branch" = "(detached)" ]; then
		if [ "$oid" = "(initial)" ]; then
			commit="$green_color${oid}$undo_color"
		else
			commit="$red_color${oid:0:9}$undo_color"
		fi
	else
		commit="$green_color${branch}$undo_color"
	fi

	local status
	if [ -n "$conflict" ]; then
		status="$red_color${conflict}$undo_color"
	elif [ -n "$modified" ]; then
		status="$red_color${modified}$undo_color"
	elif [ -n "$staged" ]; then
		status="$green_color${staged}$undo_color"
	elif [ "$oid" = "(initial)" ]; then
		status="$green_color#$undo_color"
	fi

	[ -z "${untracked}" ] || status="${status}$red_color${untracked}$undo_color"

	case "${ab}" in
	"+0 -0") status="${status}=" ;;
	"+0 -"*) status="${status}<" ;;
	"+"*" -0") status="${status}>" ;;
	"+"*" -"*) status="${status}<>" ;;
	esac

	[ -z "${status}" ] || status=" ${status}"

	PS1="$PS1 (${commit}${status})"
}

__set_ps1_py_venv() {
	# Let's only check for a virtual environment if the VIRTUAL_ENV variable is
	# set. This should eek out a little more performance when we're not in one
	# since we won't need to call basename.
	if [ -z "${VIRTUAL_ENV}" ] || [ -n "${VIRTUAL_ENV_DISABLE_PROMPT:-}" ]; then
		return
	fi

	# The python venv module hard-codes the name of the virtual environment into
	# the activate script for my configuration, so we need to pull it out of
	# VIRTUAL_ENV to have an appropriate prefix. If we're doing that, might has
	# well comment out the hard-coded part and rely on the else in the
	# if-statement that follows it.
	#
	#if [ "x(env) " != x ] ; then
	#	PS1="(env) ${PS1:-}"
	#else

	local venv_color="\[\e[0;35m\]"
	local undo_color="\[\e[m\]"

	local venv_name="${VIRTUAL_ENV##*/}"
	if [ "$venv_name" = "__" ] ; then
		# Special case for Aspen magic directories
		# See http://www.zetadev.com/software/aspen/
		venv_name="${VIRTUAL_ENV%/*}"
		venv_name="${venv_name##*/}"
	fi

	PS1="($venv_color${venv_name}$undo_color) $PS1"
}

__git_ps1_venv() {
	__set_ps1_clean      # Set normal PS1 first
	__set_ps1_py_venv    # Alter with python venv
	__set_ps1_git_status # Alter with git status

	PS1="${PS1}\\\$ "
}

# Set or update PROMPT_COMMAND
case "$PROMPT_COMMAND" in
*__git_ps1_venv*)
	# Already contains our git prompt, skip
	;;
"${PROMPT_COMMAND:-x}")
	# Non-empty: add semicolon and fallthrough
	PROMPT_COMMAND=$PROMPT_COMMAND';'
	;&
*)
	# Add our git_ps1 command
	PROMPT_COMMAND=$PROMPT_COMMAND'__git_ps1_venv'
esac

# Setup default PS1 as a fallback
__set_ps1_clean
PS1="$PS1\\\$ "
