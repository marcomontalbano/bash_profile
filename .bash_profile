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

# set the console title
function console__set_title {
    title="$1"
    trap 'echo -ne "\033]0;"$title"\007"' DEBUG
}

# proxy - unset
function proxy__unset {
    unset HTTP_PROXY
    unset HTTPS_PROXY
    unset http_proxy
    unset https_proxy

    unset npm_config_proxy
    unset npm_config_https_proxy

    #sudo npm config delete proxy
    #sudo npm config delete https-proxy
}

# proxy - set
function proxy__set {
    export HTTP_PROXY=$1
    export HTTPS_PROXY=$HTTP_PROXY
    export http_proxy=$HTTP_PROXY
    export https_proxy=$HTTPS_PROXY

    export npm_config_proxy=$HTTP_PROXY
    export npm_config_https_proxy=$HTTPS_PROXY

    #sudo npm config set proxy $HTTP_PROXY
    #sudo npm config set https-proxy $HTTPS_PROXY
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

# get the current branch name
function __git__branch_name {
    echo $(git symbolic-ref HEAD 2>/dev/null | awk -Frefs\/heads\/ '{print $NF}')
    #echo $(git symbolic-ref HEAD 2>/dev/null | awk -F\/ '{print $NF}')
}

# check & get the formatted branch name
function __git__dirty {
    status=$(git status 2> /dev/null | tail -n 1)
    if [[ $status != "nothing to commit, working tree clean" ]]; then
        echo $COLOR_MAGENTA$(__git__branch_name)$COLOR_YELLOW
    else
        echo $(__git__branch_name)
    fi
}

# check & get if you have unpulled changes
function __git__unpulled {
    logdiff=$(git log HEAD..origin/$(__git__branch_name) --oneline 2> /dev/null) || return
    if [[ $logdiff != "" ]]; then
        echo "("$COLOR_MAGENTA"’git pull origin $(__git__branch_name)’"$COLOR_YELLOW" required)"
    fi
}

# check & get if you have unpushed changes
function __git__unpushed {
    logdiff=$(git log origin/$(__git__branch_name)..HEAD --oneline 2> /dev/null) || return
    if [[ $logdiff != "" ]]; then
        echo "("$COLOR_MAGENTA"’git push origin $(__git__branch_name)’"$COLOR_YELLOW" required)"
    fi
}

# check & get if you need to create a new branch
function __git__new_branch {
    brinfo=$(git branch -r | grep "origin/"$(__git__branch_name))
    if [[ $brinfo == "" ]]; then
        echo "("$COLOR_RED"new branch"$COLOR_YELLOW" | "$COLOR_MAGENTA"’git push origin $(__git__branch_name)’"$COLOR_YELLOW" required)"
    fi
}

# get the status of current branch
function __git__status {
    unpulled=$(__git__unpulled)
    unpushed=$(__git__unpushed)
    newbrach=$(__git__new_branch)
    
    if [[ $newbrach != "" ]]; then
        echo $newbrach
    fi
    
    if [[ $unpulled != "" && $unpushed != "" ]]; then
        echo "("$RED"’git push origin $(__git__branch_name) --force’"$COLOR_YELLOW" required)"
    else
        if [[ $unpulled != "" ]]; then
            echo $unpulled
        fi
        
        if [[ $unpushed != "" ]]; then
            echo $unpushed
        fi
    fi
}

# compose a useful string containing git information
function gitify {
    ref=$(git symbolic-ref HEAD 2> /dev/null) || return
    echo -e "\n[GIT branch: $(__git__dirty)] $(__git__status)"
}

# Bash Completions
[[ -r "$HOME/.bash_completion_git" ]] && source ~/.bash_completion_git



###########
### SVN ###
###########

# get the current branch name
function __svn__branch_name {
    url=$(svn info | grep "^URL" | awk '{print $NF}')
    repository_root=$(svn info | grep "^Repository Root" | awk '{print $NF}')
    
    # relative_url
    echo "${url/$repository_root/^}"
}

function __svn__untracked_files {
  new_files=$(svn status | grep "?" | awk '{print $NF}')
  echo $new_files
}

# check & get the formatted branch name
function __svn__dirty {
    status=$(svn status 2> /dev/null | tail -n 1)
    if [[ $status != "" ]]; then
        echo $COLOR_MAGENTA$(__svn__branch_name)$COLOR_YELLOW
    else
        echo $(__svn__branch_name)
    fi
}

# compose a useful string containing svn information
function svnify {
    ref=$(svn info 2> /dev/null) || return
    echo -e "\n[SVN branch: $(__svn__dirty)] "
}

# Bash Completions
[[ -r "$HOME/.bash_completion_svn" ]] && source ~/.bash_completion_svn



###########
### PS1 ###
###########

PS1="\n\[$COLOR_GREEN\][\w]\[$COLOR_YELLOW\]\$(gitify)\$(svnify)\n\[$COLOR_CYAN\][\u@\h \$] \[$COLOR_RED\]> \[$COLOR_NORMAL\]"



###############
### EXPORTS ###
###############

export GIT_EDITOR="vim"
export SVN_EDITOR="vim"
export EDITOR="vim"
export CLICOLOR=1
export LSCOLORS=gxfxcxdxbxegedabagacad
