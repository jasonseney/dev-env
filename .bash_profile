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

# View formatted JSON from the clipboard
if hash jq 2>/dev/null; then
    alias jsonview="pbpaste | jq . -r | vim - \"+set ft=javascript fdm=indent\""
else
    alias jsonview="pbpaste | python -m json.tool | vim - \"+set ft=javascript fdm=indent\""
fi

# *** Functions ***

# Open secure files
vimdecrypt() { gpg -d "$1" | vim - -n -i "NONE" "+set filetype=$2"; }

# Download files from teh webz
# Usage: `downlod http://somesite.com/folder/myfile.txt`
# Downloads `myfile.txt` in pwd, using the name from url
download() { curl -o ${1##*/} $1; }

# Ruby Environment
# eval "$(rbenv init -)"

# Git Scripts
source ~/git-prompt.sh
source ~/git-completion.sh

# Command Prompt (requires git-prompt)
red=$(      tput setaf 1)
green=$(    tput setaf 2)
yellow=$(   tput setaf 3)
blue=$(     tput setaf 4)
magenta=$(  tput setaf 5)
cyan=$(     tput setaf 6)
white=$(    tput setaf 7)
reset=$(    tput sgr0   )

export PS1='\[$magenta\]\W\[$cyan\]$(\__git_ps1) \[$green\]\$ \[$reset\]'

# Fix incorrect text width in shell with custom PS1
shopt -s checkwinsize

# Use Homebrew apps first
export PATH="/usr/local/bin:/usr/local/sbin:~/bin:$PATH"
