# .zshrc for android by rhythmcache.t.me
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

#CustomAndroid

alias devinfo='getprop ro.product.device && getprop ro.build.version.release && getprop ro.build.id'
alias androidver='getprop ro.build.version.release'
alias codename='getprop ro.product.device'
alias buildid='getprop ro.build.id'
alias uptime='cat /proc/uptime | awk "{print \$1 / 60 \" minutes\"}"'
alias kernel='uname -r'
alias battery='dumpsys battery'
alias batlevel='dumpsys battery | grep level'
alias charging='dumpsys battery | grep "powered"'
alias ipinfo='ip addr show'
alias wifiinfo='dumpsys wifi | grep "Wi-Fi" -A 5'
alias connections='netstat -tupan'
alias pingtest='ping -c 5 google.com'
alias storage='df -h | grep /data'
alias sdinfo='ls -la /storage/emulated/0'
alias tmp='cd /data/local/tmp'
alias freestorage='df -h | grep -E "(Filesystem|/data)"'
alias pslist='ps -A'
alias topapps='top -n 1 | head -n 20'
alias killapp='killall'



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

# Welcome message ( disabled it ,, it was cringe )
#echo "${fg_bold[red]}Welcome back, $USER!${reset_color}"
#echo "${fg_bold[yellow]}$(date '+%A, %B %d, %Y %H:%M:%S')${reset_color}"
#echo "${fg_bold[green]}Terminal ready...${reset_color}\n"

# Set terminal title
precmd() {
    print -Pn "\e]0;%~\a"
}

# Better command line editing
setopt INTERACTIVE_COMMENTS
setopt NO_BEEP
setopt EXTENDED_GLOB
setopt RC_QUOTES


restart() {
    if [[ -z "$1" ]]; then
        echo "Usage: restartservice <service_name>"
        return 1
    fi
    su -c "stop $1 && start $1"
    echo "Service $1 restarted."
}

#2

logcatgrep() {
    if [[ -z "$1" ]]; then
        echo "Usage: logcatgrep <keyword>"
        return 1
    fi
    logcat | grep "$1"
}

#3
listapps() {
    pm list packages | sed 's/^package://g' | sort
}

#4

searchapp() {
    if [[ -z "$1" ]]; then
        echo "Usage: searchapp <keyword>"
        return 1
    fi
    pm list packages | sed 's/^package://g' | grep "$1"
}




#5

cpuusage() {
    top -n 1 | head -n 15
}


#6

get_uid() {
	package="$1"
	uid="$(pm list packages -U | grep "^package:$package " | sed 's/.*uid:\([0-9]*\).*/\1/' | cut -d',' -f1)"
	[ ! -n "$uid" ] && return 1
	echo "$uid"
	return 0
}

#7



appinfo() {
    if [[ -z "$1" ]]; then
        echo "Usage: appinfo <package_name>"
        return 1
    fi

    local package="$1"
    echo "Fetching information for package: $package"

    # UID
    echo "\n👤 UID:"
    get_uid "$package"
    echo "\n📦 App Size:"
    du -h $(pm path "$package" | sed 's/package://g') 2>/dev/null

    # App version info
    echo "\n📜 Version Info:"
    dumpsys package "$package" | grep -E "versionName|versionCode"
}



# Directly Export Paths with Error Suppression
export PATH="$PATH:/system/system_ext/bin" 2>/dev/null
export PATH="$PATH:/system/product/bin" 2>/dev/null
export PATH="$PATH:/system/vendor/bin" 2>/dev/null
export PATH="$PATH:/data/data/com.termux/files/usr/bin" 2>/dev/null


# Function to check if a command exists directly
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Check if busybox exists before proceeding
if command_exists busybox; then
    # Create aliases for all busybox commands that don't exist in the environment
    while IFS= read -r cmd; do
        if ! command_exists "$cmd"; then
            alias "$cmd"="busybox $cmd"
        fi
    done < <(busybox --list || echo "")
fi

# Function to execute a command, falling back to busybox if necessary
try_busybox() {
    local cmd="$1"  # First argument is the command
    shift           # Remove the command from the argument list

    if command_exists "$cmd"; then
        # If the command exists in the system, execute it
        command "$cmd" "$@"
    elif command_exists busybox && busybox --list | grep -q "^$cmd$"; then
        # If it's a busybox applet, execute it via busybox
        busybox "$cmd" "$@"
    else
        # Command is not found in the system or busybox
        echo "Command not found: $cmd (not available directly or via busybox)" >&2
        return 127
    fi
}


