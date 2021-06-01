export XDG_CACHE_HOME="/home/gc/.cache"
export XDG_CONFIG_HOME="/home/gc/.config"
export XDG_DATA_HOME="/home/gc/.local/share"

export BROWSER="brave"
export EDITOR="nvim"
export TERM="st"
export MANPAGER="nvim -c 'set ft=man' -"
export NO_AT_BRIDGE=1

export CLICOLOR=1
export GCC_COLORS="error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01"
export LESS="-M"
export PATH="$HOME/scripts:$PATH"

export GTK_IM_MODULE='fcitx'
export QT_IM_MODULE='fcitx'
export SDL_IM_MODULE='fcitx'
export XMODIFIERS='@im=fcitx'

#export GTK_IM_MODULE='ibus'
#export QT_IM_MODULE='ibus'
#export XMODIFIERS='@im=ibus'

#$HOME/ Clean-up:
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
export LESSHISTFILE="-"
export PYLINTHOME="$XDG_CACHE_HOME/pylint"
export GTK2_RC_FILES="$XDG_CONFIG_HOME/gtk-2.0/gtkrc-2.0"
export MATHEMATICA_USERBASE="$XDG_CONFIG_HOME/mathematica"
export NOTMUCH_CONFIG="$XDG_CONFIG_HOME/notmuch-config"
export WGETRC="$XDG_CONFIG_HOME/wget/wgetrc"
export XAUTHORITY="$XDG_CONFIG_HOME/x11/Xauthority"
export CARGO_HOME="$XDG_DATA_HOME/cargo"
export JULIA_DEPOT_PATH="$XDG_DATA_HOME/julia:$JULIA_DEPOT_PATH"
export GNUPGHOME="$XDG_DATA_HOME/gnupg"
export GOPATH="$XDG_DATA_HOME/go"
export CARGO_HOME="$XDG_DATA_HOME/cargo"
export RUSTUP_HOME="$XDG_DATA_HOME/rustup"
export PASSWORD_STORE_DIR="$XDG_DATA_HOME/password-store"
export SSB_HOME="$XDG_DATA_HOME/zoom"
export GRADLE_USER_HOME="$XDG_DATA_HOME/gradle"
export TEXMFHOME="$XDG_DATA_HOME/texmf"
export TEXMFVAR="$XDG_CACHE_HOME/texlive/texmf-var"
export TEXMFCONFIG="$XDG_CONFIG_HOME/texlive/texmf-config"
