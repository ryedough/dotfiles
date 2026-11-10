#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'

set -o vi

export QML_IMPORT_PATH=$PWD
export QMLLS_BUILD_DIRS="/usr/lib/qt6/qml/"
export GOPATH="$HOME/.local/share/go"
export PATH="$PATH:$HOME/.config/scripts/executable"
export PATH="$PATH:$HOME/.config/composer/vendor/bin"

export PATH="$PATH:$HOME/.esp/xtensa-lx106-elf/bin"
export IDF_PATH="$HOME/.esp/ESP8266_RTOS_SDK"

source $HOME/.config/scripts/bashrc/acd_func.sh

export PATH="$HOME/.local/bin:$PATH"
eval "$(starship init bash)"
