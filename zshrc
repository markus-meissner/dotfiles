######################################################################
# 09-03-28, mm: Added known_hosts
# 09-03-31, mm: Added backward-delete-char, minor changes
# 09-04-06, mm: Added TZ
# 09-04-08, mm: Disabled MENUCOMPLETE
# 09-04-16, mm: Added testmail alias
# 09-04-21, mm: setopt noautomenu
# 09-05-22, mm: unsetopt recexact
# 09-07-06, mm: Added ~/bin to $PATH
# 09-07-24, mm: Added alias tm
# 09-09-06, mm: Added alias iptables-*
# 09-09-08, mm: Added ping completion by sshs known host
# 09-09-10, mm: Changed wget from -nc to -N in order to update .zshrc if newer
# 09-09-17, mm: Changed wget from -nc to -N again, last changes lost
# 09-12-03, mm: Added .vimrc, less -FX
# 09-12-17, mm: Added history-incremental-pattern-search-backward for zsh>=4.3.9
# 09-12-22, mm: Added alias tml
# 10-01-16, mm: tm checks now OSTYPE, added EDITOR, edit
# 10-02-07, mm: Added 2wdropbox
# 10-03-10, mm: Increased HISTSIZE from 1000 to 10000, added HIST_IGNORE_DUPS, added CLOBBER
# 10-10-01, mm: Added mysql and mysqldump if under darwin
# 10-10-02, mm: Added notifymm
# 10-10-13, mm: wget checks now $SUDO_USER
# 10-10-19, mm: Added bindkey ^r for screen usage
# 10-11-26, mm: Removed mysql as we now use the .dmg from mysql
# 11-08-02, mm: Changed log-files for Mac OS X Lion
# 12-01-05, mm: Removed DISPLAY variable (don't even know why it was here) to enable X11
# 13-01-23, mm: Added 48hdb
# 13-02-17, mm: Added fetch (freebsd)
# 14-11-27, mm: Removed slash from some PATH entries
# 15-01-19, mm: Updated methods to find fetch, wget
# 15-01-27, mm: Moved to .dotfiles, removed wget
# 16-11-24, mm: Updated notifymm
# 18-01-09, mm: Updated tml
# 18-03-05, mm: Added / udpated lssites
# 19-03-01, mm: Added /snap/bin to PATH, added command_not_found_handler
# 20-01-08, mm: Removed alias edit
# 20-04-16, mm: Added lsusers
######################################################################

# From http://git.grml.org/f/grml-etc-core/etc/zsh/zshrc
is439(){
    [[ $ZSH_VERSION == 4.3.<9->* || $ZSH_VERSION == 4.<4->* || $ZSH_VERSION == <5->* ]] && return 0
    return 1
}

# next lets set some enviromental/shell pref stuff up
# setopt NOHUP
#setopt NOTIFY
#setopt NO_FLOW_CONTROL
setopt APPEND_HISTORY
# setopt AUTO_LIST		# these two should be turned off
# setopt AUTO_REMOVE_SLASH
# setopt AUTO_RESUME		# tries to resume command of same name
unsetopt BG_NICE		# do NOT nice bg commands
setopt EXTENDED_HISTORY		# puts timestamps in the history (extendedhistory)
				# use
# perl -lne 'm#: (\d+):\d+;(.+)# && printf "%s :: %s\n",scalar localtime $1,$2' $HISTFILE
				# to dump the history with readable timestamps
# setopt HASH_CMDS		# turns on hashing
setopt HIST_ALLOW_CLOBBER
setopt HIST_REDUCE_BLANKS
setopt HIST_IGNORE_DUPS		# ignore duplicates of the prev event
setopt INC_APPEND_HISTORY SHARE_HISTORY
setopt ALL_EXPORT

setopt CLOBBER			# Allows  `>'  redirection  to truncate existing files, and `>>' to create files (>|).
				# If you really do want to clobber a file, you can use the >! operator.

# setopt MENUCOMPLETE		# autoselect the first item in the menu after the first tab
setopt noautomenu		# don't cycle completions
# Set/unset  shell options
setopt   notify globdots pushdtohome cdablevars autolist
setopt correct correctall
setopt autocd
#setopt recexact		# this leads to a/ if tab is placed in a dir with a and aa
setopt longlistjobs
setopt   autoresume histignoredups pushdsilent noclobber
setopt   autopushd pushdminus extendedglob rcquotes mailwarning
unsetopt bgnice autoparamslash

# Autoload zsh modules when they are referenced
zmodload -a zsh/stat stat
zmodload -a zsh/zpty zpty
zmodload -a zsh/zprof zprof
# http://stackoverflow.com/a/3486417
# The zsh mapfile module creates a pseudo-variable which maps filenames
# to their contents, and is only needed if you have scripts that 
# actually use $mapfile.
# zmodload -ap zsh/mapfile mapfile


PATH="$HOME/bin:/opt/local/bin:/opt/local/sbin:/usr/local/bin:/usr/local/sbin:$PATH"
if [ -d "/snap/bin" ] ; then
    export PATH="$PATH:/snap/bin"
fi

HISTFILE=$HOME/.zhistory
HISTSIZE=10000
SAVEHIST=10000
HOSTNAME="`hostname`"
PAGER='less -FX'
EDITOR='vim'

source ~/.dotfiles/zsh/prompt.zsh

#LANGUAGE=
LC_ALL='en_US.UTF-8'
LANG='en_US.UTF-8'
LC_CTYPE=C
#DISPLAY=:0

if [ $SSH_TTY ]; then
  MUTT_EDITOR=vim
else
  MUTT_EDITOR=emacsclient.emacs-snapshot
fi

unsetopt ALL_EXPORT
# # --------------------------------------------------------------------
# # aliases
# # --------------------------------------------------------------------
alias slrn="slrn -n"
alias man='LC_ALL=C LANG=C man'
alias f=finger
alias l='ls -al'
alias ll='ls -al'
#alias ls='ls --color=auto '
alias dmesg="sudo dmesg"
alias lssites='{ find /etc/*/sites-enabled/ -type l; find /etc/nginx/conf.d/ -type f -name "server-*.conf" } | xargs ls -l'
# uid 65534 is on most systems "nobody"
alias lsusers='awk -F: ''($3 >= 1000 && $3 < 65534) {printf "%s:%s\n",$1,$3}'' /etc/passwd'
alias notifymm='echo|mail -s "Job on $HOSTNAME done at `date +"%F %H:%M:%S"`" mm@im.meissner.it'
alias testmail='echo|mail -s "Test von $HOSTNAME um `date`" '
if [[ ${OSTYPE} = darwin* ]]; then
	alias tm='sudo tail -F /var/log/system.log /var/log/secure.log'
elif [[ ${OSTYPE} = freebsd* ]]; then
    alias tm='sudo tail -F /var/log/auth.log /var/log/cron /var/log/security /var/log/messages'
elif [[ ${VENDOR} = "redhat" ]]; then
    # Red Hat Enterprise Linux Server release 6.6 (Santiago)
    alias tm='sudo tail -F /var/log/secure /var/log/cron /var/log/messages'
else 
    alias tm='sudo tail -F /var/log/auth.log /var/log/syslog'
fi
alias tml='sudo tail -F $(sudo find /var/log -name dovecot.log -o -name maillog -o -name mail.log)'
alias iptables-l='sudo iptables -n --line-numbers -L'
alias iptables-la='sudo iptables-l -v; iptables-l -v -t nat'
alias ifconfig='/sbin/ifconfig'
alias route='/sbin/route'
alias -g 2wdb="meissner@ivar.meissner.it:/home/meissner/smit/htdocs/dl/2week_dropbox/"
alias -g 48hdb="meissner@ivar.meissner.it:/home/meissner/smit/htdocs/dl/48h_dropbox/"
alias brew="sudo -H -u adm brew"

# global alias will be expanded at any place in the command line
alias -g less=$PAGER
alias -g grep="grep --color"
# removed alias edit as "systectl edit" will not work with it

# alias	=clear
# https://stackoverflow.com/questions/9701366/vim-backspace-leaves
# stty erase ^H &>/dev/null
bindkey "^[[3~"	delete-char
bindkey "^?"	backward-delete-char
#chpwd() {
#     [[ -t 1 ]] || return
#     case $TERM in
#     sun-cmd) print -Pn "\e]l%~\e\\"
#     ;;
#    *xterm*|screen|rxvt|(dt|k|E)term) print -Pn "\e]2;%~\a"
#    ;;
#    esac
#}

#chpwd

autoload -U compinit
compinit -u

# mmv replacement (http://www.zshwiki.org/home/builtin/functions/zmv)
autoload -U zmv

# history-incremental-pattern-search-backward was added in 4.3.9 which is not available in lenny-backports
# use the new *-pattern-* widgets for incremental history search
if is439 ; then
    bindkey '^r' history-incremental-pattern-search-backward
    bindkey '^s' history-incremental-pattern-search-forward
else
    # history-incremental-search-backward seems to be the default
    bindkey '^r' history-incremental-search-backward
fi

bindkey "^[[5~" up-line-or-history
bindkey "^[[6~" down-line-or-history
bindkey "^[[H" beginning-of-line
bindkey "^[[1~" beginning-of-line
bindkey "^[[F"  end-of-line
bindkey "^[[4~" end-of-line
bindkey ' ' magic-space    # also do history expansion on space
bindkey '^I' complete-word # complete on tab, leave expansion to _expand

zstyle ':completion::complete:*' use-cache on
zstyle ':completion::complete:*' cache-path ~/.zsh/cache/$HOST

zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-prompt '%SAt %p: Hit TAB for more, or the character to insert%s'
zstyle ':completion:*' menu select=1 _complete _ignored _approximate
zstyle -e ':completion:*:approximate:*' max-errors \
    'reply=( $(( ($#PREFIX+$#SUFFIX)/2 )) numeric )'
zstyle ':completion:*' select-prompt '%SScrolling active: current selection at %p%s'
zstyle ':completion:*:processes' command 'ps -axw'
zstyle ':completion:*:processes-names' command 'ps -awxho command'
# Completion Styles
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
# list of completers to use
zstyle ':completion:*::::' completer _expand _complete _ignored _approximate

# allow one error for every three characters typed in approximate completer
zstyle -e ':completion:*:approximate:*' max-errors \
    'reply=( $(( ($#PREFIX+$#SUFFIX)/2 )) numeric )'
    
# insert all expansions for expand completer
zstyle ':completion:*:expand:*' tag-order all-expansions
#
#NEW completion:
# 1. All /etc/hosts hostnames are in autocomplete
# 2. If you have a comment in /etc/hosts like #%foobar.domain,
#    then foobar.domain will show up in autocomplete!
zstyle ':completion:*' hosts $(awk '/^[^#]/ {print $2 $3" "$4" "$5}' /etc/hosts | grep -v ip6- && grep "^#%" /etc/hosts | awk -F% '{print $2}') 
# formatting and messages
zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions' format '%B%d%b'
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:warnings' format 'No matches for: %d'
zstyle ':completion:*:corrections' format '%B%d (errors: %e)%b'
zstyle ':completion:*' group-name ''

# match uppercase from lowercase
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# offer indexes before parameters in subscripts
zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters

# command for process lists, the local web server details and host completion
#zstyle ':completion:*:processes' command 'ps -o pid,s,nice,stime,args'
#zstyle ':completion:*:urls' local 'www' '/var/www/htdocs' 'public_html'
zstyle '*' hosts $hosts

# Filename suffixes to ignore during completion (except after rm command)
zstyle ':completion:*:*:(^rm):*:*files' ignored-patterns '*?.o' '*?.c~' \
    '*?.old' '*?.pro'
# the same for old style completion
#fignore=(.o .c~ .old .pro)

# ignore completion functions (until the _ignored completer)
zstyle ':completion:*:functions' ignored-patterns '_*'
zstyle ':completion:*:scp:*' tag-order \
   files users 'hosts:-host hosts:-domain:domain hosts:-ipaddr"IP\ Address *'
zstyle ':completion:*:scp:*' group-order \
   files all-files users hosts-domain hosts-host hosts-ipaddr
zstyle ':completion:*:ssh:*' tag-order \
   users 'hosts:-host hosts:-domain:domain hosts:-ipaddr"IP\ Address *'
zstyle ':completion:*:ssh:*' group-order \
   hosts-domain hosts-host users hosts-ipaddr
zstyle '*' single-ignored show

# ssh completion
if [ -f $HOME/.ssh/known_hosts ]; then
    local knownhosts
    knownhosts=( ${${${${(f)"$(<$HOME/.ssh/known_hosts)"}:#[0-9]*}%%\ *}%%,*} )
    zstyle ':completion:*:(ssh|scp|sftp|ping):*' hosts $knownhosts
fi

case $TERM in
    *xterm*|ansi)
		function settab { print -Pn "\e]1;%n@%m: %~\a" }
		function settitle { print -Pn "\e]2;%n@%m: %~\a" }
		function chpwd { settab;settitle }
		settab;settitle
        ;;
esac

growl() { echo -e $'\e]9;'${1}'\007' ; return  ; }

TZ='Europe/Berlin'; export TZ

source ~/.dotfiles/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

if [[ -f /etc/zsh_command_not_found ]]; then
    source /etc/zsh_command_not_found
fi

if [[ $USER == "root" ]]; then
    echo "No selfupdate as user root, call ~/.dotfiles/selfupdate manually if needed"
elif [[ -f ~/.dotfiles/.selfupdate-disabled ]]; then
    echo "Selfupdate has been disabled, call ~/.dotfiles/selfupdate manually if needed"
else
    ~/.dotfiles/selfupdate
fi

if which git 1>/dev/null; then
    echo "Markus dotfiles v$(cd ~/.dotfiles; git log -n1 --pretty=format:"%ad" --date=short)"
else
    echo "Markus dotfiles - no git, no version"
fi
