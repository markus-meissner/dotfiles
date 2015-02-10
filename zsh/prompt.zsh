autoload -U colors
colors

#export LSCOLORS="Gxfxcxdxbxegedabagacad"
setopt prompt_subst

ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[red]%}%{✚%G%}%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[green]%}%{✔%G%}%{$reset_color%}"
# %{$fg_bold[green]%}

# show git branch/tag, or name-rev if on detached head
parse_git_branch() {
    (command git symbolic-ref -q HEAD || command git name-rev --name-only --no-undefined --always HEAD) 2>/dev/null
}

# show red star if there are uncommitted changes
parse_git_dirty() {
    if command git diff-index --quiet HEAD 2> /dev/null; then
      echo "$ZSH_THEME_GIT_PROMPT_CLEAN"
    else
      echo "$ZSH_THEME_GIT_PROMPT_DIRTY"
    fi
}

# if in a git repo, show dirty indicator + git branch
git_custom_status() {
    local git_where="$(parse_git_branch)"
    [ -n "$git_where" ] && echo " - [${git_where#(refs/heads/|tags/)}|$(parse_git_dirty)%{$reset_color%}]"
}

if [[ $USER == "root" ]]; then
    PS1_PREFIX="$PR_RED%n$PR_NO_COLOR@"
elif [[ ( $USER != "meissner" ) && ( $USER != "mmeissner" ) ]]; then
    PS1_PREFIX="$PR_BLUE%n$PR_NO_COLOR@"
else
    PS1_PREFIX=""
fi

PS1='%{$fg[green]%}%m%{$reset_color%}:%{$fg[blue]%}%4c%{$reset_color%}$(git_custom_status)
%(!.#.$) '
RPS1="%{$(echotc UP 1)%}(%D{%Y-%m-%d %H:%M})%{$(echotc DO 1)%}"
#RPS1="$PR_BLUE(%D{%y-%m-%d %H:%M})$PR_NO_COLOR"
