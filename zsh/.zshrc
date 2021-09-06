#   ____    ____
#  / ___|  / ___|
# | |  _  | |
# | |_| | | |___
#  \____|  \____|

[ -z $DISPLAY ] && [ $XDG_VTNR -eq 1 ] && startx ~/.config/x11/xinitrc


# Enable colors and change prompt:
autoload -U colors && colors	# Load colors
setopt prompt_subst
PROMPT="%B%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[cyan]%}%M %{$fg[magenta]%}%~ $%b "
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
#setopt HIST_IGNORE_ALL_DUPS     # do not put duplicated command into history list
#setopt HIST_SAVE_NO_DUPS        # do not save duplicated command
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
	cp ~/Documents/LaTeX/templete.tex ~/Documents/LaTeX/$1 && vi ~/Documents/LaTeX/$1
}

dt () {
	dict $1 | cat
}

wf () {
	doas cat /etc/NetworkManager/system-connections/"$1".nmconnection
}

# Basic auto/tab complete:
autoload -U compinit
compinit
zstyle ':completion::complete:*' use-cache 1
zstyle ':completion:*' menu select
zmodload zsh/complist
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

alias nvim=''
alias GIT='git add . && git commit && git push'
alias bud='bluetoothctl power on && bluetoothctl -- connect A3:B8:30:E3:AB:2B'
alias cfp='vi ~/dotfiles/portage/make.conf'
alias cfv='vi ~/.config/nvim/init.vim'
alias cfz='vi ~/.config/zsh/.zshrc'
alias cp='cp -iv'
alias df='df -h'
alias diff='diff --color=auto'
alias fixmine='rm -rf ~/.minecraft/launcher'
alias fixpac='doas rm /var/lib/paman/db.lck'
alias font='fontpreview-ueberzug'
alias grep='grep --color=auto'
alias grub='doas vi /etc/default/grub && doas grub-mkconfig -o /boot/grub/grub.cfg'
alias henlo='echo henlo'
alias hist="fc -l 1 | awk '{print $2}' | dmenu -l 50 | xclip -selection clipboard"
alias history='fc -l 1'
alias ka='killall'
alias l='ls -A --group-directories-first'
alias lf='lfcd'
alias ll='ls -Al --group-directories-first'
alias libvirt='doas /etc/init.d/libvirtd start'
alias ls='ls --color=auto'
alias matrix='unimatrix -ab -s 96'
alias miniso='bluetoothctl power on && bluetoothctl -- connect FC:58:FA:B5:63:3C'
alias mk='doas make clean install'
alias mkd='mkdir -pv'
alias mv='mv -iv'
alias myip='curl ifconfig.co'
alias pg='ping -c 3 gentoo.org'
alias pp='prettyping -c 3 archlinux.org'
alias multir='xrandr --output HDMI1 --mode 1920x1080 --right-of eDP1'
alias multiu='xrandr --output HDMI1 --mode 1920x1080 --above eDP1'
alias projecc='xrandr --output HDMI1 --mode 1920x1080'
alias single='xrandr --output HDMI1 --off'
alias reboot='doas reboot'
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
alias wget='wget --hsts-file="$XDG_CACHE_HOME/wget-hsts"'
alias yt='youtube-dl --add-metadata -i'
alias yta='yt -x -f bestaudio/best'

# Load syntax highlighting; should be last.
source /usr/share/zsh/site-functions/zsh-syntax-highlighting.zsh
