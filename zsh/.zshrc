#   ____    ____
#  / ___|  / ___|
# | |  _  | |
# | |_| | | |___
#  \____|  \____|

[ -z $DISPLAY ] && [ $XDG_VTNR -eq 1 ] && $(startx ~/.config/x11/xinitrc)

[ -f /etc/bash.command-not-found ] && . /etc/bash.command-not-found

# humble flex
#pfetch
#uwufetch
#colorscript random

# Enable colors and change prompt:
autoload -U colors && colors	# Load colors
PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[cyan]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}$%b "
precmd() $funcstack[1]() echo   # Print lines between commands
setopt autocd                   # Automatically cd into typed directory.
stty stop undef		        # Disable ctrl-s to freeze terminal.
setopt interactive_comments

# Report command running time if it is more than 3 seconds
REPORTTIME=3

# Keep a lot of history
HISTFILE=~/.config/zsh/history
HISTSIZE=10000000
SAVEHIST=10000000
# Add commands to history as they are entered, don't wait for shell to exit
setopt INC_APPEND_HISTORY
# Also remember command start time and duration
setopt EXTENDED_HISTORY
# Do not keep duplicate commands in history
setopt HIST_IGNORE_ALL_DUPS
# Do not remember commands that start with a whitespace
setopt HIST_IGNORE_SPACE
# Correct spelling of all arguments in the command line
setopt CORRECT_ALL
# Enable autocompletion
zstyle ':completion:*' completer _complete _correct _approximate

newsh () {
	doas touch /usr/local/bin/$1 && doas chown gc /usr/local/bin/$1 && doas chmod 755 /usr/local/bin/$1 && echo '#!/bin/sh' > /usr/local/bin/$1 && nvim /usr/local/bin/$1
}

newtex () {
	cp ~/Documents/LaTeX/templete.tex ~/Documents/LaTeX/$1 && nvim ~/Documents/LaTeX/$1
}

dt () {
	dict $1 | bat
}


wf () {
	doas bat /etc/NetworkManager/system-connections/"$1".nmconnection
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
function zle-keymap-select {
  if [[ $KEYMAP == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'
  elif [[ $KEYMAP == main ]] ||
       [[ $KEYMAP == viins ]] ||
       [[ $KEYMAP = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.


# Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line

alias GIT='git add . && git commit && git push'
alias bud='bluetoothctl power on && bluetoothctl -- connect A3:B8:30:E3:AB:2B'
alias cfzsh='nvim ~/.config/zsh/.zshrc'
alias cfnvim='nvim ~/.config/nvim/init.vim'
alias cp='cp -iv'
alias df='df -h'
alias fixmine='rm -rf ~/.minecraft/launcher'
alias fixpac='doas rm /var/lib/paman/db.lck'
alias font='fontpreview-ueberzug'
alias grep='grep --color=auto'
alias grub='doas nvim /etc/default/grub && doas grub-mkconfig -o /boot/grub/grub.cfg'
alias henlo='echo henlo'
alias ka='killall'
alias l='ls -A --group-directories-first'
alias ll='ls -Al --group-directories-first'
alias ls='ls --color=auto'
alias matrix='unimatrix -ab -s 96'
alias miniso='bluetoothctl power on && bluetoothctl -- connect FC:58:FA:B5:63:3C'
alias mk='doas make clean install'
alias mkd='mkdir -pv'
alias mv='mv -iv'
alias myip='curl ipinfo.io/ip && printf "\n"'
alias pg='ping -c 3 archlinux.org'
alias multil='xrandr --output HDMI1 --right-of eDP1'
alias multiu='xrandr --output HDMI1 --above eDP1'
alias rm='rm -iv'
alias ro='chmod 446'
alias rr='curl -s -L http://bit.ly/10hA8iC | bash'
alias sc='source ~/.bashrc'
alias sptf='spotifyd && spt'
alias sun='echo sun'
alias tex='cd ~/Documents/LaTeX'
alias umk='doas make clean uninstall'
alias weather='curl wttr.in/Singapore'
alias yt='youtube-dl'
alias yta='youtube-dl --extract-audio --audio-quality 0'

# Load syntax highlighting; should be last.
source /usr/share/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh 2>/dev/null

#source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

export HSTR_CONFIG=hicolor
# get more colors
setopt histignorespace
# skip cmds w/ leading space from history
bindkey -s "\C-r" "\C-a hstr -- \C-j" # bind hstr to Ctrl-r (for Vi mode check doc)

eval "$(starship init zsh)"
