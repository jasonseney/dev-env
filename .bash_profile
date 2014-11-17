#Bash Profile - For OS X

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

if hash jq 2>/dev/null; then
    alias jsonview="pbpaste | jq . -r | mvim - \"+set ft=javascript fdm=indent\""
else
    alias jsonview="pbpaste | python -m json.tool | mvim - \"+set ft=javascript fdm=indent\""
fi

# Protect yourself from yourself
alias rm="echo '*** WARNING: USE trash INSTEAD!!! ***'; rm -i"

# *** Functions ***

# Open secure files
vimdecrypt() { gpg -d "$1" | vim - -n -i "NONE" "+set filetype=$2"; }

# Download files from teh webz
# Usage: `downlod http://somesite.com/folder/myfile.txt`
# Downloads `myfile.txt` in pwd, using the name from url
download() { curl -o ${1##*/} $1; }

# Git 
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
bold=$(     tput bold   )
reset=$(    tput sgr0   )

export PS1='\[$magenta\]\W\[$cyan\]$(\__git_ps1) \[$green\]\$ \[$reset\]'
function set_tab_title {
    echo -ne "\033]0; ${PWD##*/} $(__git_ps1)\007"
}
PROMPT_COMMAND="set_tab_title ; $PROMPT_COMMAND"

shopt -s checkwinsize

export PATH="/usr/local/bin:/usr/local/sbin:~/bin:$PATH"

# Github Enterprise
# export GITHUB_URL=https://xxx/
# export GITHUB_HOST=xxx

# Homebrew
# export HOMEBREW_GITHUB_API_TOKEN=''

# Ruby & Node
eval "$(rbenv init -)"

export NVM_DIR=~/.nvm
source $(brew --prefix nvm)/nvm.sh

# Quick Web Server!
alias server='open http://localhost:8000 && python -m SimpleHTTPServer'

# Shows a basic stat diff between current banch and remote master
compare() { printf "Comparing current branch to origin/master...\n"; git fetch; git diff --stat origin/master...; }
