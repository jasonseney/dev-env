# Bash Profile - For OS X

# *** Shortcuts ***
alias ..="cd .."
alias ...="cd .. ; cd .."

alias ls="ls -G" # list
alias la="ls -Ga" # list all, includes dot files
alias ll="ls -Gl" # long list, excludes dot files
alias lla="ls -Gla" # long list all, includes dot files

alias stfu="osascript -e 'set volume output muted true'"
alias pumpitup="sudo osascript -e 'set volume 10'"

# *** Network ***
# Get readable list of network IPs
alias ips="ifconfig -a | perl -nle'/(\d+\.\d+\.\d+\.\d+)/ && print $1'"
alias myip="dig +short myip.opendns.com @resolver1.opendns.com"
alias flushdns="dscacheutil -flushcache" # Flush DNS cache

# *** Misc ***
alias gzip="gzip -9n" # set strongest compression level as ‘default’ for gzip
alias ping="ping -c 5" # ping 5 times ‘by default’
alias ql="qlmanage -p 2>/dev/null" # preview a file using QuickLook

# Protect yourself from yourself
alias rm="echo '*** WARNING: USE trash INSTEAD!!! ***'; rm -i"

# *** Functions ***

# Open secure files
vimdecrypt() { gpg -d "$1" | vim - -n -i "NONE" "+set filetype=$2"; }

# Download files from teh webz
# Usage: `downlod http://somesite.com/folder/myfile.txt`
# Downloads `myfile.txt` in pwd, using the name from url
download() { curl -o ${1##*/} $1; }

# Ruby Environment
eval "$(rbenv init -)"

# Git Scripts
source ~/.git-prompt.sh

# Command Prompt
export PS1='\033[0;35m\W\033[0;36m$(__git_ps1) \033[0;32m\$ \033[0m'

