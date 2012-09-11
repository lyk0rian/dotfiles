export LESS="-R"
export HOME=${HOME:-/Users/bey0nd}
# for macports
export PATH=/usr/local/bin:/usr/local/sbin:$PATH
#export TERM=${TERM:-cons25r}
export COLORTERM=$TERM
#export PAGER=/usr/bin/vimpager
export PAGER=/usr/bin/less
export EDITOR=/usr/bin/vim
#export EDITOR=/usr/bin/mcedit
#export BLOCKSIZE=${BLOCKSIZE:-K}
export BLOCKSIZE=1024K
export LANG=en_US.UTF-8
export MM_CHARSET=${LANG:-ru_RU.UTF-8}
export LC_ALL=${LANG:-ru_RU.UTF-8}
export LC_MESSAGES=C
#export PS1='[32m[[33m%m@%2/[32m]%#[36m '
export PS1='[%m@%2/]%# '
#export PS1='\[\033[01;31m\]\h \[\033[01;34m\]\W \$ \[\033[00m\]'
export PS_PERSONALITY='linux'
export CLICOLOR=1 # colors for e.g. ls on mac

limit -s coredumpsize 0


alias be='bundle exec'
alias h='history 25'
alias j='jobs -l'
alias la='ls -la'
alias lf='ls -FA'
alias ll='ls -lAFo'
alias man="man -a"
alias halt="poweroff"


# ---[ Key bindings ]--------------------------------------------------
bindkey -e
bindkey "^[[3~" delete-char
bindkey '\eq' push-line-or-edit
bindkey '^p' history-search-backward
bindkey "^[[3A"  history-beginning-search-backward
bindkey "^[[3B"  history-beginning-search-forward
bindkey -s '^B' " &\n"

# ---[ Shell functions ]-----------------------------------------------
setenv() { typeset -x "${1}${1:+=}${(@)argv[2,$#]}" }  # csh compatibility
freload() { while (( $# )); do; unfunction $1; autoload -U $1; shift; done }
# Simple commandline calculator
function calc () {
    awk "BEGIN { print $@ }"
}

# ---[ Terminal settings ]---------------------------------------------
case "$TERM" in
    linux)
        bindkey '\e[1~' beginning-of-line   # Home
        bindkey '\e[4~' end-of-line     # End
        bindkey '\e[3~' delete-char     # Del
        bindkey '\e[2~' overwrite-mode      # Insert
        ;;
    screen)
        # In Linux console
        bindkey '\e[1~' beginning-of-line   # Home
        bindkey '\e[4~' end-of-line     # End
        bindkey '\e[3~' delete-char     # Del
        bindkey '\e[2~' overwrite-mode      # Insert
        bindkey '\e[7~' beginning-of-line   # home
        bindkey '\e[8~' end-of-line     # end
        # In rxvt
        bindkey '\eOc' forward-word     # ctrl cursor right
        bindkey '\eOd' backward-word        # ctrl cursor left
        bindkey '\e[3~' backward-delete-char    # This should not be necessary!
        ;;
    rxvt*)
        bindkey '\e[7~' beginning-of-line   # home
        bindkey '\e[8~' end-of-line     # end
        bindkey '\eOc' forward-word     # ctrl cursor right
        bindkey '\eOd' backward-word        # ctrl cursor left
        bindkey '\e[3~' backward-delete-char    # This should not be necessary!
        bindkey '\e[2~' overwrite-mode      # Insert
        ;;
    xterm*)
        bindkey "\e[H" beginning-of-line   # Home
        bindkey "\e[1~" beginning-of-line   # Home
        bindkey "\e[4~" end-of-line     # End
        bindkey "\e[F" end-of-line     # End
        bindkey '\e[3~' delete-char     # Del
        bindkey '\e[2~' overwrite-mode      # Insert
        ;;
    sun)
        bindkey '\e[214z' beginning-of-line       # Home
        bindkey '\e[220z' end-of-line             # End
        bindkey '^J'      delete-char             # Del
        bindkey '^H'      backward-delete-char    # Backspace
        bindkey '\e[247z' overwrite-mode          # Insert
        ;;
    cons25r)
        bindkey "^?"	  delete-char		# BSD console delete
        ;;
esac


# Syntax highlight for less with 'source-highlite'
PAGER='less -X -M'



# Stay compatible to sh and IFS
setopt  SH_WORD_SPLIT

setopt notify globdots pushdtohome
setopt recexact longlistjobs
setopt autoresume pushdsilent
setopt pushdminus extendedglob rcquotes mailwarning
setopt histignorealldups
setopt autopushd
setopt nohup
setopt incappendhistory
setopt printexitvalue
setopt appendhistory
setopt APPEND_HISTORY
setopt AUTO_LIST
setopt AUTO_MENU
unsetopt BG_NICE HUP autoparamslash

#setopt EMACS

# History
setopt INC_APPEND_HISTORY EXTENDED_HISTORY HIST_IGNORE_DUPS HIST_FIND_NO_DUPS
setopt EXTENDED_HISTORY HIST_EXPIRE_DUPS_FIRST
setopt HIST_REDUCE_BLANKS HIST_SAVE_NO_DUPS
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.history
DIRSTACKSIZE=20

# Job Control
setopt CHECK_JOBS NO_HUP

# Midnight Commander chdir enhancement for gentoo
if [ -f /usr/share/mc/mc.gentoo ]; then
 . /usr/share/mc/mc.gentoo
fi


# Don't expand files matching:
fignore=(.o .c~ .old .pro)


#Completions

autoload -U compinit
compinit -i

zmodload -i zsh/complist


# Cache completions
zstyle ':completion::complete:*' use-cache on
mkdir -p ~/.cache/zsh/$HOST
zstyle ':completion::complete:*' cache-path ~/.cache/zsh/$HOST



zstyle ':completion:*::::' completer _expand _complete _ignored _approximate
zstyle ':completion:*' menu select=1 _complete _ignored _approximate
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

zstyle ':vcs_info:*' actionformats '%F{5}(%f%s%F{5})%F{3}-%F{5}[%F{2}%b%F{3}|%F{1}%a%F{5}]%f '
zstyle ':vcs_info:*' formats '%F{5}(%f%s%F{5})%F{3}-%F{5}[%F{2}%b%F{5}]%f '
zstyle ':vcs_info:*' enable git

# Separate matches into groups
zstyle ':*:matches' group 'yes'
# Describe each match group.
zstyle ':*:descriptions' format "%B---- %d%b"

# Messages/warnings format
zstyle ':*:messages' format '%B%U---- %d%u%b'
zstyle ':*:descriptions' format "%B---- %d%b"
zstyle ':*:warnings' format '%B%U---- no match for: %d%u%b'

# Describe options in full
zstyle ':*:options' description 'yes'
zstyle ':*:options' auto-description '%d'

zstyle ':completion:*:processes' command 'ps -xuf'
zstyle ':completion:*:processes' sort false
zstyle ':completion:*:processes-names' command 'ps xho command'
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' menu yes select

# Style lists
zstyle ':completion:*' list-colors ''
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*' list-prompt '%SAt %p: Hit TAB for more, or the character to insert%s'
zstyle ':completion:*' select-prompt '%SScrolling active: current selection at %p%s'

# Style messages, descriptions, warnings and corrections
zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions' format '%B%d%b'
zstyle ':completion:*:warnings' format 'No matches for: %d'
zstyle ':completion:*:corrections' format '%B%d (errors: %e)%b'
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*' group-name ''

zstyle ':completion:*:functions' ignored-patterns '_*'
zstyle ':completion:*:scp:*' group-order files all-files users hosts-domain hosts-host hosts-ipaddr
zstyle ':completion:*:ssh:*' group-order hosts-domain hosts-host users hosts-ipaddr
zstyle ':completion:*:scp:*' tag-order files users 'hosts:-host hosts:-domain:domain hosts:-ipaddr"IP\ Address *'
zstyle ':completion:*:ssh:*' tag-order users 'hosts:-host hosts:-domain:domain hosts:-ipaddr"IP\ Address *'
zstyle '*' single-ignored show


setopt autocd
case $TERM in
    xterm* | rxvt)
      precmd(){print -Pn "\e]0;%n@%m: %~\a"}
       ;;
esac

hosts=(${${${(f)"$(<$HOME/.ssh/known_hosts)"}%%\ *}%%,*})
zstyle ':completion:*:hosts' hosts $hosts

zmodload -a zsh/stat stat
zmodload -a zsh/zpty zpty
zmodload -ap zsh/mapfile mapfile


#Then, as the superuser do this:
#    >   mount -t cgroup cgroup /sys/fs/cgroup/cpu -o cpu
#    >   mkdir -m 0777 /sys/fs/cgroup/cpu/user
#
#if [ "$PS1" ] ; then  
#        mkdir -m 0700 /sys/fs/cgroup/cpu/user/$$
#        echo $$ > /sys/fs/cgroup/cpu/user/$$/tasks
#fi
#
#

SSH_ENV="$HOME/.ssh/environment"

function start_agent {
     echo "Initialising new SSH agent..."
     /usr/bin/ssh-agent | sed 's/^echo/#echo/' > "${SSH_ENV}"
     echo succeeded
     chmod 600 "${SSH_ENV}"
     . "${SSH_ENV}" > /dev/null
     /usr/bin/ssh-add;
}

# Source SSH settings, if applicable

if [ -f "${SSH_ENV}" ]; then
     . "${SSH_ENV}" > /dev/null
     #ps ${SSH_AGENT_PID} doesn't work under cywgin
     ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || {
         start_agent;
     }
else
     start_agent;
fi

# show diff on git commit
export GIT_EDITOR='vim -c "new|silent r! git diff --cached" -c "set syntax=diff buftype=nofile" -c "silent 1|wincmd j"'


PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm" # Load RVM function


# vim: set sw=4 sts=4 et tw=80 :
