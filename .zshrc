# users generic .zshrc file for zsh(1)

## Environment variable configuration
#
# LANG
#
export LANG=ja_JP.UTF-8


## Default shell configuration
#
# set prompt
#
autoload colors
colors
case ${UID} in
0)
    PROMPT="%B%{${fg[red]}%}%/#%{${reset_color}%}%b "
    PROMPT2="%B%{${fg[red]}%}%_#%{${reset_color}%}%b "
    SPROMPT="%B%{${fg[red]}%}%r is correct? [n,y,a,e]:%{${reset_color}%}%b "
    [ -n "${REMOTEHOST}${SSH_CONNECTION}" ] && 
        PROMPT="%{${fg[cyan]}%}$(echo ${HOST%%.*} | tr '[a-z]' '[A-Z]') ${PROMPT}"
    ;;
*)
    PROMPT="%{${fg[red]}%}%/%%%{${reset_color}%} "
    PROMPT2="%{${fg[red]}%}%_%%%{${reset_color}%} "
    SPROMPT="%{${fg[red]}%}%r is correct? [n,y,a,e]:%{${reset_color}%} "
    [ -n "${REMOTEHOST}${SSH_CONNECTION}" ] && 
        PROMPT="%{${fg[cyan]}%}$(echo ${HOST%%.*} | tr '[a-z]' '[A-Z]') ${PROMPT}"
    ;;
esac

# auto change directory
#
setopt auto_cd

# auto directory pushd that you can get dirs list by cd -[tab]
#
setopt auto_pushd

# command correct edition before each completion attempt
#
setopt correct

# compacked complete list display
#
setopt list_packed

# no remove postfix slash of command line
#
setopt noautoremoveslash

# no beep sound when complete list displayed
#
setopt nolistbeep

## Keybind configuration
#
# emacs like keybind (e.x. Ctrl-a goes to head of a line and Ctrl-e goes 
#   to end of it)
#
bindkey -e

# historical backward/forward search with linehead string binded to ^P/^N
#
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^p" history-beginning-search-backward-end
bindkey "^n" history-beginning-search-forward-end
bindkey "\\ep" history-beginning-search-backward-end
bindkey "\\en" history-beginning-search-forward-end


## Command history configuration
#
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt hist_ignore_dups     # ignore duplication command history list
setopt share_history        # share command history data


## Completion configuration
#
fpath=(~/.zsh/functions/Completion ${fpath})
autoload -U compinit
compinit


## zsh editor
#
autoload zed


## Prediction configuration
#
#autoload predict-on
#predict-off


case "${OSTYPE}" in
darwin*)
    alias updateports="sudo port selfupdate; sudo port outdated"
    alias portupgrade="sudo port upgrade installed"
    ;;
freebsd*)
    case ${UID} in
    0)
        updateports() 
        {
            if [ -f /usr/ports/.portsnap.INDEX ]
            then
                portsnap fetch update
            else
                portsnap fetch extract update
            fi
            (cd /usr/ports/; make index)

            portversion -v -l \<
        }
        alias appsupgrade='pkgdb -F && BATCH=YES NO_CHECKSUM=YES portupgrade -a'
        ;;
    esac
    ;;
esac


## terminal configuration
#
unset LSCOLORS
case "${TERM}" in
xterm)
    export TERM=xterm-color
    ;;
kterm)
    export TERM=kterm-color
    # set BackSpace control character
    stty erase
    ;;
cons25)
    unset LANG
    export LSCOLORS=ExFxCxdxBxegedabagacad
    export LS_COLORS='di=01;34:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
    zstyle ':completion:*' list-colors \
        'di=;34;1' 'ln=;35;1' 'so=;32;1' 'ex=31;1' 'bd=46;34' 'cd=43;34'
    ;;
esac

# set terminal title including current directory
#
case "${TERM}" in
kterm*|xterm*)
    precmd() {
        echo -ne "\033]0;${USER}@${HOST%%.*}:${PWD}\007"
    }
    export LSCOLORS=exfxcxdxbxegedabagacad
    #export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
    export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30'
    zstyle ':completion:*' list-colors \
        'di=34' 'ln=35' 'so=32' 'ex=31' 'bd=46;34' 'cd=43;34'
    ;;
esac

#
# add_env via BTO
# http://blog.bz2.jp/archives/2006/02/tarball.html
#
function add_env(){
env_name=$1
shift

for i in $@; do
    if ! dirs=`eval echo $i` > /dev/null 2>&1; then
        continue
    fi

    for i in `eval echo $dirs`; do
        if eval echo \$$env_name | egrep '(\:|^)'$i'(\:|$)' >/dev/null 2>&1;
        then
            continue
        fi

        if [ -d $i ]; then
            eval $env_name=\$$env_name:$i
        fi
    done
done
}

PATH=
add_env PATH "${HOME}/bin" "${HOME}/sbin"
add_env PATH "${HOME}/opt/*/bin" "${HOME}/opt/*/sbin"
add_env PATH "/usr/local/bin" "/usr/local/sbin"
add_env PATH "/usr/local/*/bin" "/usr/local/*/sbin"
add_env PATH "/opt/local/bin" "/opt/local/sbin"
add_env PATH "/opt/local/*/bin" "/opt/local/*/sbin"
add_env PATH "/opt/*/bin" "/opt/*/sbin"
add_env PATH "/usr/ucb"
add_env PATH "/bin" "/sbin" "/x/bin"
add_env PATH "/usr/bin" "/usr/sbin" "/usr/*/bin" "/usr/*/sbin"
export PATH

MANPATH=
add_env MANPATH "${HOME}/man" "${HOME}/opt/*/man/ja" "${HOME}/opt/*/man"
add_env MANPATH "/usr/local/man/ja" "/usr/local/man"
add_env MANPATH "/usr/local/*/man/ja" "/usr/local/*/man"
add_env MANPATH "/opt/local/man/ja" "/opt/local/man"
add_env MANPATH "/opt/local/*/man/ja" "/opt/local/*/man"
add_env MANPATH "/opt/*/man/ja" "/opt/*/man"
add_env MANPATH "/usr/share/jman"
add_env MANPATH "/usr/*/man/ja"
add_env MANPATH "/usr/*/man"
add_env MANPATH "/usr/man/ja" "/usr/man"
export MANPATH

LD_LIBRARY_PATH=
add_env LD_LIBRARY_PATH "${HOME}/lib" "${HOME}/opt/*/lib"
add_env LD_LIBRARY_PATH "/usr/local/lib" "/usr/local/*/lib"
add_env LD_LIBRARY_PATH "/opt/local/lib" "/opt/local/*/lib"
add_env LD_LIBRARY_PATH "/opt/*/lib"
add_env LD_LIBRARY_PATH "/lib"
add_env LD_LIBRARY_PATH "/usr/lib"
add_env LD_LIBRARY_PATH "/usr/*/lib"
export LD_LIBRARY_PATH

LIBRARY_PATH=
add_env LIBRARY_PATH "${HOME}/lib" "${HOME}/opt/*/lib"
add_env LIBRARY_PATH "/usr/local/lib" "/usr/local/*/lib"
add_env LIBRARY_PATH "/opt/local/lib" "/opt/local/*/lib"
add_env LIBRARY_PATH "/opt/*/lib"
add_env LIBRARY_PATH "/lib"
add_env LIBRARY_PATH "/usr/lib"
add_env LIBRARY_PATH "/usr/*/lib"
export LIBRARY_PATH

C_INCLUDE_PATH=
add_env C_INCLUDE_PATH "${HOME}/include" "${HOME}/opt/*/include"
add_env C_INCLUDE_PATH "/usr/local/include" "/usr/local/*/include"
add_env C_INCLUDE_PATH "/opt/local/include" "/opt/local/*/include"
add_env C_INCLUDE_PATH "/opt/*/include"
add_env C_INCLUDE_PATH "/usr/include"
add_env C_INCLUDE_PATH "/usr/*/include"
export C_INCLUDE_PATH

unset USERNAME


## Alias configuration
#
# expand aliases before completing
#
setopt complete_aliases     # aliased ls needs if file/dir completions work

alias where="command -v"
alias j="jobs -l"

#case "${OSTYPE}" in
#freebsd*|darwin*)
#    alias ls="ls -G -w"
#    ;;
#linux*)
#    alias ls="ls --color"
#    ;;
#esac

alias ls="ls --color"
alias la="ls -a"
alias lf="ls -F"
alias ll="ls -lF"
alias l="ls -lFa"

alias du="du -h"
alias df="df -h"

alias su="su -l"

alias vi='vim'
alias em='emacs'
alias macvim='env LANG=ja_JP.UTF-8 /Applications/MacVim.app/Contents/MacOS/Vim "$@"'
alias scr='screen -R'

# mfiler
export EDITOR='vim'
export PAGER='less'
export SHELL='bash'

alias mint='mfiler2'
alias remint='rm ~/.mfinfo && mfiler2'
alias keys='ssh-add -l'

# subversion
export SVN_EDITOR='vim'
export SVN_SSH='ssh'

alias svnst='svn st'
alias svnup='svn up'
alias cmt='svn commit'

# ssh-agent
#if [ -e $HOME/.ssh/agent-env ]; then
#        . $HOME/.ssh/agent-env
#fi
agent="$HOME/.ssh-agent-`hostname`"
if [ -S "$agent" ]; then
    export SSH_AUTH_SOCK=$agent
elif [ ! -S "$SSH_AUTH_SOCK" ]; then
    export SSH_AUTH_SOCK=$agent
elif [ ! -L "$SSH_AUTH_SOCK" ]; then
    ln -snf "$SSH_AUTH_SOCK" $agent && export SSH_AUTH_SOCK=$agent
fi

## load user .zshrc configuration file
#
[ -f ~/.zshrc.mine ] && source ~/.zshrc.mine
