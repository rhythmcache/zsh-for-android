# .zshrc for android by coldnw.t.me
# github.com/rhythmcache
# Load colors
autoload -U colors && colors

# Custom color variables
local android_codename=$(getprop ro.product.device)  # Hardcode if getprop is unreliable
local current_user="${USER:-$(whoami)}"

# Conditional coloring for non-root users
if [[ $EUID -ne 0 ]]; then
    local user_color="%{$fg_bold[green]%}"  # Green for non-root
    local arrow_color="%{$fg_bold[blue]%}"  # Blue for non-root
    local symbol_color="%{$fg_bold[green]%}"  # Green for non-root
else
    local user_color="%{$fg_bold[red]%}"  # Red for root
    local arrow_color="%{$fg_bold[red]%}"  # Red for root
    local symbol_color="%{$fg_bold[red]%}"  # Red for root
fi

local user_host="${user_color}${current_user}@${android_codename}%{$reset_color%}"
local current_dir="%{$fg_bold[blue]%}%~%{$reset_color%}"

# Prompt symbol and arrow styling
local prompt_arrows="${arrow_color}❯❯❯%{$reset_color%}"
local prompt_symbol="${symbol_color}#%{$reset_color%}"  # Default for root
[[ $EUID -ne 0 ]] && prompt_symbol="${symbol_color}$%{$reset_color%}"

# Stylish prompt with emojis and colors
PROMPT=$'\n'"╭─${user_host} in ${current_dir}"$'\n'"╰─${prompt_arrows}${prompt_symbol} "

# Right-side prompt showing time
RPROMPT="%{$fg_bold[yellow]%}[%*]%{$reset_color%}"

# Custom separator for directory listing
PROMPT_EOL_MARK="➜"

# Fancy aliases with colors
alias ls='ls --color=auto'
alias ll='ls -alF --color=auto'
alias la='ls -A --color=auto'
alias l='ls -CF --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias diff='diff --color=auto'
alias c='clear'
alias h='history'
alias ..='cd ..'
alias ...='cd ../..'
alias md='mkdir -p'
alias rd='rmdir'
alias reload='source ~/.zshrc'

# Directory colors
export CLICOLOR=1
export LSCOLORS="ExGxFxdaCxDaDahbadacec"

# History settings with larger size
HISTFILE=~/.zsh_history
HISTSIZE=50000
SAVEHIST=50000
setopt appendhistory
setopt INC_APPEND_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_FIND_NO_DUPS
setopt HIST_REDUCE_BLANKS

# Enhanced tab completion with colors
autoload -U compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zmodload zsh/complist
compinit
_comp_options+=(globdots)

# Directory navigation
setopt AUTO_CD
setopt AUTO_PUSHD
setopt PUSHD_IGNORE_DUPS
setopt PUSHD_SILENT

# Colorful man pages
man() {
    env \
    LESS_TERMCAP_mb=$'\e[01;31m' \
    LESS_TERMCAP_md=$'\e[01;34m' \
    LESS_TERMCAP_me=$'\e[0m' \
    LESS_TERMCAP_se=$'\e[0m' \
    LESS_TERMCAP_so=$'\e[01;44;33m' \
    LESS_TERMCAP_ue=$'\e[0m' \
    LESS_TERMCAP_us=$'\e[01;32m' \
    man "$@"
}

# Colorful directory listing
lsd() {
    echo "\n📁 ${fg_bold[cyan]}Directories:${reset_color}"
    ls -la "$@" | grep "^d"
    echo "\n📄 ${fg_bold[yellow]}Files:${reset_color}"
    ls -la "$@" | grep "^-"
    echo "\n🔗 ${fg_bold[magenta]}Links:${reset_color}"
    ls -la "$@" | grep "^l"
}

# Welcome message
echo "${fg_bold[red]}Welcome back, $USER!${reset_color}"
echo "${fg_bold[yellow]}$(date '+%A, %B %d, %Y %H:%M:%S')${reset_color}"
echo "${fg_bold[green]}Terminal ready...${reset_color}\n"

# Set terminal title
precmd() {
    print -Pn "\e]0;%~\a"
}

# Better command line editing
setopt INTERACTIVE_COMMENTS
setopt NO_BEEP
setopt EXTENDED_GLOB
setopt RC_QUOTES
