######################## OWN CONFIGURATION #########################
# Configured by init-server script
#
# -------------------------------------------------------------------
# Terminal
# -------------------------------------------------------------------
# Define colors
BOLD_BLUE="\[\e[1;94m\]"
GREEN="\[\e[32m\]"
RED="\[\e[91m\]"
BOLD_RED="\[\e[1;91m\]"
CYAN="\[\e[36m\]"
RESET="\[\e[0m\]"
WHITE="\e[97m\]"

PROMPT_COMMAND='update_prompt'

# Build PS1
PS1="${BOLD_RED}╭─\u@\h${RESET} "     # user@host
PS1+="${WHITE}\$(show_ssh)${RESET}"   # custom SSH indicator
PS1+="${GREEN}\w${RESET} "            # working dir
PS1+="${RED}\$(parse_git_branch)${RESET} "  # git branch
PS1+="${CYAN}\$(get_python_venv)${RESET} "  # python venv
PS1+="${RED}\${EXIT_CODE_DISPLAY}${RESET}"  # last exit code (only if !=0)
PS1+="\n${BOLD_RED}╰─\$ ${RESET}"           # new line + prompt symbol

# -------------------------------------------------------------------
# Aliases
# -------------------------------------------------------------------


# -------------------------------------------------------------------
# History format
# -------------------------------------------------------------------
HISTTIMEFORMAT="| %d/%m/%y | %T | "

# -------------------------------------------------------------------
# Shorter PATH in bash
# -------------------------------------------------------------------
PROMPT_DIRTRIM=3

# -------------------------------------------------------------------
# Own functions
# -------------------------------------------------------------------
function parse_git_branch() {
    branch=$(git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/')
    if [[ $branch ]] ; then
        echo "git:$branch"
    fi
}

function get_python_venv() {
    if [[ $VIRTUAL_ENV ]]; then
        echo "py:($(basename $VIRTUAL_ENV))"
    fi
}

function show_ssh() {
  if [[ -n "$SSH_CONNECTION" ]]; then
    local ssh_server_ip=$(echo $SSH_CONNECTION | awk '{print $3}')
    echo -e "[SSH:$ssh_server_ip] "
  else
    echo ""
  fi
}

function explain_code_error() {
  case $1 in
    0)   echo "OK" ;;
    1)   echo "FAIL" ;;           # General failure
    2)   echo "USAGE" ;;          # Misuse of shell builtins
    126) echo "NOPERM" ;;         # Command invoked cannot execute (permission)
    127) echo "NOTFND" ;;         # Command not found
    128) echo "BADEXIT" ;;        # Invalid exit argument
    130) echo "CTRL-C" ;;         # Script terminated by Control-C
    137) echo "KILLED" ;;         # Process killed (kill -9)
    139) echo "CRASH" ;;          # Segmentation fault
    143) echo "STOP" ;;           # Script terminated by SIGTERM
    *)   echo "$1" ;;             # Show actual exit code for others
  esac
}

function update_prompt() {
  local last_exit=$?
  
  if [ "$last_exit" -ne 0 ]; then
    EXIT_CODE_DISPLAY="✗ $(explain_code_error "$last_exit")"
  else
    EXIT_CODE_DISPLAY=""
  fi
}

# -------------------------------------------------------------------
# Exports
# -------------------------------------------------------------------
# Set default editor as vim
export EDITOR=vim
# Disable python venv auto prompt
export VIRTUAL_ENV_DISABLE_PROMPT=1

######################################################################