#   ____    ____
#  / ___|  / ___|
# | |  _  | |
# | |_| | | |___
#  \____|  \____|

[ -z $DISPLAY ] && [ $XDG_VTNR -eq 1 ] && startx ~/.config/x11/xinitrc


# Enable colors and change prompt:
autoload -U colors && colors	# Load colors
setopt prompt_subst
PROMPT="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[cyan]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}$%b "
RPROMPT="%D{(%a) %d %b %y | %H:%M:%S}"
#PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[cyan]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}$%b "
precmd() $funcstack[1]() echo   # Print lines between commands
setopt autocd                   # Automatically cd into typed directory.
stty stop undef		            # Disable ctrl-s to freeze terminal.
setopt interactive_comments

# Report command running time if it is more than 3 seconds
REPORTTIME=3

# Keep a lot of history
HISTSIZE=10000000
SAVEHIST=10000000
HISTFILE=~/.cache/zsh/history
setopt HIST_IGNORE_ALL_DUPS     # do not put duplicated command into history list
setopt HIST_SAVE_NO_DUPS        # do not save duplicated command
setopt HIST_REDUCE_BLANKS       # remove unnecessary blanks
setopt INC_APPEND_HISTORY_TIME  # append command to history file immediately after execution
setopt EXTENDED_HISTORY         # record command start time

covid () {
    curl https://corona-stats.online/$1
}

news () {
    curl getnews.tech/$1
}

newtex () {
	cp ~/Documents/LaTeX/templete.tex ~/Documents/LaTeX/$1 && nvim ~/Documents/LaTeX/$1
}

dt () {
	dict $1 | cat
}

wf () {
	doas cat /etc/NetworkManager/system-connections/"$1".nmconnection
}

# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)		# Include hidden files.

# vi mode
bindkey -v
export KEYTIMEOUT=1

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

# Change cursor shape for different vi modes.
function zle-keymap-select () {
    case $KEYMAP in
        vicmd) echo -ne '\e[1 q';;      # block
        viins|main) echo -ne '\e[5 q';; # beam
    esac
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

# Use lf to switch directories and bind it to ctrl-o
lfcd () {
    tmp="$(mktemp)"
    lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        rm -f "$tmp" >/dev/null
        [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
    fi
}

bindkey -s '^a' 'bc -lq\n'

bindkey -s '^f' 'cd "$(dirname "$(fzf)")"\n'

bindkey '^[[P' delete-char

# Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line

alias GIT='git add . && git commit && git push'
alias bud='bluetoothctl power on && bluetoothctl -- connect A3:B8:30:E3:AB:2B'
alias cfz='nvim ~/.config/zsh/.zshrc'
alias cfv='nvim ~/.config/nvim/init.vim'
alias cp='cp -iv'
alias df='df -h'
alias diff='diff --color=auto'
alias fixmine='rm -rf ~/.minecraft/launcher'
alias fixpac='doas rm /var/lib/paman/db.lck'
alias font='fontpreview-ueberzug'
alias grep='grep --color=auto'
alias grub='doas nvim /etc/default/grub && doas grub-mkconfig -o /boot/grub/grub.cfg'
alias henlo='echo henlo'
alias hist="fc -l 1 | awk '{print $2}' | dmenu -l 50 | xclip -selection clipboard"
alias history='fc -l 1'
alias ka='killall'
alias l='ls -A --group-directories-first'
alias lf='lfcd'
alias ll='ls -Al --group-directories-first'
alias libvirt='systemctl start libvirtd'
alias ls='ls --color=auto'
alias matrix='unimatrix -ab -s 96'
alias miniso='bluetoothctl power on && bluetoothctl -- connect FC:58:FA:B5:63:3C'
alias mk='doas make clean install'
alias mkd='mkdir -pv'
alias mv='mv -iv'
alias myip='curl ifconfig.co'
alias pg='ping -c 3 archlinux.org'
alias pp='prettyping -c 3 archlinux.org'
alias multir='xrandr --output HDMI1 --mode 1920x1080 --right-of eDP1'
alias multiu='xrandr --output HDMI1 --mode 1920x1080 --above eDP1'
alias rm='rm -iv'
alias ro='chmod 446'
alias rr='curl -s -L http://bit.ly/10hA8iC | bash'
alias sc='source ~/.bashrc'
alias sptf='spotifyd && spt'
alias sun='echo sun'
alias stx='startx ~/.config/x11/xinitrc'
alias tex='cd ~/Documents/LaTeX'
alias umk='doas make clean uninstall'
alias weather='curl wttr.in/Singapore'
alias yt='youtube-dl --add-metadata -i'
alias yta='yt -x -f bestaudio/best'

# Load syntax highlighting; should be last.
source /usr/share/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh 2>/dev/null
