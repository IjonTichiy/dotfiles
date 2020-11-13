# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Get aliases 
if [ -f ~/.bash_alias ]; then
    . ~/.bash_alias
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]
then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

source ~/liquidprompt/liquidprompt

# liquidprompt prefix to show running process in GNU screen window name
LP_PS1_PREFIX="\[\\033k\\033\\\\\]"

# fix non-KDE desktop
export QT_QPA_PLATFORMTHEME=qt5ct

export PAGER=/home/user/.local/bin/vimpager

if ! [[ "$PATH" =~ "/usr/local/pgsql/bin:" ]]
then
    PATH="/usr/local/pgsql/bin:$PATH"
fi

export PATH

export PGDATA=/home/user/.local/postgres_data

# custom completion for python virtualenvs
source ~/.virtualenvs/activate-completion.bash
