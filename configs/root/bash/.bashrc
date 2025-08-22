
######################## OWN CONFIGURATION #########################
# Configured by init-server script
#
# -------------------------------------------------------------------
# Terminal
# -------------------------------------------------------------------
PS1='\[\e[1;91m\]╭─\u@\h\[\e[0m\] $(show_ssh)\[\e[32m\]\w\[\e[0m\] \[\e[91m\]$(parse_git_branch)\[\e[00m\] \[\e[36m\]$(get_python_venv)\[\e[00m\]\n\[\e[91m\]╰─\$ \[\e[0m\]'

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
    echo -e "\e[97m[SSH:$ssh_server_ip]\e[0m "
  else
    echo ""
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