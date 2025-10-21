# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Get aliases 
if [ -f $BASH_ALIAS ]; then
    . $BASH_ALIAS
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]
then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# fix non-KDE desktop
export QT_QPA_PLATFORMTHEME=qt5ct

export XDG_CONFIG_DIR=~/.config

export VIMRC=~/.vimrc
export VIM_FILETYPES=$XDG_CONFIG_DIR/vim/filetype.vim
export VIM_PLUGINS=$XDG_CONFIG_DIR/vim/plugins.vim
export VIM_HELPERS=$XDG_CONFIG_DIR/vim/helper.vim
export BASHRC=~/.bashrc
export BASH_ALIAS=$XDG_CONFIG_DIR/bash/bash_alias

export PATH

bind -f ~/.inputrc

# source ~/.venv/bin/activate
