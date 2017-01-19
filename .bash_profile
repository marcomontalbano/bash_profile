# # # # # # # # # # # # # # # # # # # # # # # # # # # #
#    _             _                     __ _ _       #
#   | |__  __ _ __| |_     _ __ _ _ ___ / _(_) |___   #
#  _| '_ \/ _` (_-< ' \   | '_ \ '_/ _ \  _| | / -_)  #
# (_)_.__/\__,_/__/_||_|__| .__/_| \___/_| |_|_\___|  #
#                     |___|_|                         #
# # # # # # # # # # # # # # # # # # # # # # # # # # # #



##############
### COLORS ###
##############

# Change the prompt color using tput
# http://www.thegeekstuff.com/2008/09/bash-shell-ps1-10-examples-to-make-your-linux-prompt-like-angelina-jolie/
# Set a background color using ANSI escape
SETAB_BLACK=$(tput setab 0)
SETAB_RED=$(tput setab 1)
SETAB_GREEN=$(tput setab 2)
SETAB_YELLOW=$(tput setab 3)
SETAB_BLUE=$(tput setab 4)
SETAB_MAGENTA=$(tput setab 5)
SETAB_CYAN=$(tput setab 6)
SETAB_GRAY=$(tput setab 7)
# Set a foreground color using ANSI escape
SETAF_BLACK=$(tput setaf 0)
SETAF_RED=$(tput setaf 1)
SETAF_GREEN=$(tput setaf 2)
SETAF_YELLOW=$(tput setaf 3)
SETAF_BLUE=$(tput setaf 4)
SETAF_MAGENTA=$(tput setaf 5)
SETAF_CYAN=$(tput setaf 6)
SETAF_GRAY=$(tput setaf 7)

# 
COLOR_ESC="\033"
COLOR_NORMAL=$COLOR_ESC"[0;0m"
COLOR_RED=$COLOR_ESC"[0;31m"
COLOR_ALT_RED=$COLOR_ESC"[1;31m"
COLOR_GREEN=$COLOR_ESC"[0;32m"
COLOR_ALT_GREEN=$COLOR_ESC"[1;32m"
COLOR_YELLOW=$COLOR_ESC"[0;33m"
COLOR_ALT_YELLOW=$COLOR_ESC"[1;33m"
COLOR_BLUE=$COLOR_ESC"[0;34m"
COLOR_ALT_BLUE=$COLOR_ESC"[1;34m"
COLOR_MAGENTA="$COLOR_ESC[0;35m"
COLOR_ALT_MAGENTA="$COLOR_ESC[1;35m"
COLOR_CYAN="$COLOR_ESC[0;36m"
COLOR_ALT_CYAN="$COLOR_ESC[1;36m"



###############
### ALIASES ###
###############

alias psg='ps aux | grep'
alias ll='ls -hal'
alias grep='grep --color'
alias matrix='LC_ALL=C tr -c "[:digit:]" " " < /dev/urandom | dd cbs=$COLUMNS conv=unblock | GREP_COLOR="1;32" grep --color "[^ ]"'
alias lastchanges='find . -type f -print0 | xargs -0 stat -f "%m %N" | sort -rn | cut -f2- -d" "'

alias flush__memcached="echo 'flush_all' | nc localhost 11211"
alias flush__dns="dscacheutil -flushcache"

#alias reset_launchpad="defaults write com.apple.dock ResetLaunchPad -bool true && killall Dock"



###############
### UTILITY ###
###############

# bash_profile reload profile
function bash_profile__reload {
    [[ -r "$HOME/.bash_profile" ]] && source ~/.bash_profile
    [[ -r "$HOME/.bashrc" ]] && source ~/.bashrc
}

# bash_profile update
function bash_profile__update {
    git -C $(dirname "$BASH_SOURCE") checkout . && git -C $(dirname "$BASH_SOURCE") pull -r && bash_profile__reload
}

# bash_profile move to project folder
function bash_profile__cd {
    cd $(dirname "$BASH_SOURCE")
}

# set the console title (OSX Terminal only)
function console__set_title {
    title="$1"
    trap 'echo -ne "\033]0;"$title"\007"' DEBUG
}

# check if a program is installed. (true or false returns)
function cli__is_installed {
    local is_installed=true
    type $1 >/dev/null 2>&1 || { local is_installed=false; }
    echo "$is_installed"
}

# proxy - set
function proxy__set {
    export HTTP_PROXY=$1
    export HTTPS_PROXY=$HTTP_PROXY

    if [[ -n $2 ]]; then
        export HTTPS_PROXY=$2
    fi

    export http_proxy=$HTTP_PROXY
    export https_proxy=$HTTPS_PROXY

    if [[ $(cli__is_installed npm) == true ]]; then
        export npm_config_proxy=$HTTP_PROXY
        export npm_config_https_proxy=$HTTPS_PROXY

        npm config set proxy $HTTP_PROXY
        npm config set https-proxy $HTTPS_PROXY
    fi

    if [[ $(cli__is_installed apm) == true ]]; then
        apm config set http-proxy $HTTP_PROXY
        apm config set https-proxy $HTTPS_PROXY
    fi
}

# proxy - unset
function proxy__unset {
    unset HTTP_PROXY
    unset HTTPS_PROXY
    unset http_proxy
    unset https_proxy

    if [[ $(cli__is_installed npm) == true ]]; then
        unset npm_config_proxy
        unset npm_config_https_proxy

        npm config delete proxy
        npm config delete https-proxy
    fi

    if [[ $(cli__is_installed apm) == true ]]; then
        apm config delete http-proxy
        apm config delete https-proxy
    fi
}



############
### JAVA ###
############

# set JAVA_HOME ( ex:. java--use-jdk 1.8 )
function java__use_jdk {
    export JAVA_HOME=$(/usr/libexec/java_home -v $@)
}



###########
### GIT ###
###########

# compose a useful string containing git information
function gitify {
    echo ""
}

[[ $(cli__is_installed git) == true ]] && source ~/bash_profile/.bash_profile__git

# Bash Completions
[[ -r "$HOME/bash_profile/.bash_completion_git" ]] && source ~/bash_profile/.bash_completion_git



###########
### SVN ###
###########

# compose a useful string containing svn information
function svnify {
    echo ""
}

[[ $(cli__is_installed svn) == true ]] && source ~/bash_profile/.bash_profile__svn

# Bash Completions
[[ -r "$HOME/bash_profile/.bash_completion_svn" ]] && source ~/bash_profile/.bash_completion_svn



###########
### SSH ###
###########

# Bash Completions
[[ -r "$HOME/bash_profile/.bash_completion_ssh" ]] && source ~/bash_profile/.bash_completion_ssh



###########
### PS1 ###
###########

function bash_profile__set_prompt {
    PS1="\n\[$COLOR_GREEN\][\w]\[$COLOR_YELLOW\] $(gitify) $(svnify) \n\[$COLOR_CYAN\][\u@\h \$] \[$COLOR_RED\]> \[$COLOR_NORMAL\]"
}

export PROMPT_COMMAND="bash_profile__set_prompt; $PROMPT_COMMAND"



###############
### EXPORTS ###
###############

export GIT_EDITOR="vim"
export SVN_EDITOR="vim"
export EDITOR="vim"
export CLICOLOR=1
export LSCOLORS=gxfxcxdxbxegedabagacad
