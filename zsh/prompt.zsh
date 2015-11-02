autoload -U colors
colors

#export LSCOLORS="Gxfxcxdxbxegedabagacad"
setopt prompt_subst

# http://sebastiancelis.com/2009/11/16/zsh-prompt-git-users/
# another nice prompt: https://github.com/olivierverdier/zsh-git-prompt
update_current_git_vars() {
    unset __CURRENT_GIT_BRANCH
    unset __CURRENT_GIT_BRANCH_STATUS
    unset __CURRENT_GIT_BRANCH_IS_DIRTY

    if which timeout > /dev/null; then
        # Terminate git on large repositories
	local st="$(timeout 2 git status 2>/dev/null|head; echo $pipestatus[1])"
    else
        local st="$(git status 2>/dev/null|head; echo $pipestatus[1])"
    fi
    if [[ -n "$st" ]]; then
        local -a arr
        arr=(${(f)st})

        if [[ $arr[1] =~ 'Not currently on any branch.' ]]; then
            __CURRENT_GIT_BRANCH='no-branch'
	elif [[ $arr[1] == '128' ]]; then
	    # nothing to do - we are not in a git repo
	elif [[ $arr[1] == '124' ]]; then
	    __CURRENT_GIT_BRANCH='git-timed-out'
        else
            __CURRENT_GIT_BRANCH="${arr[1][(w)4]}";
        fi

        if [[ $arr[2] =~ 'Your branch is' ]]; then
            if [[ $arr[2] =~ 'ahead' ]]; then
                __CURRENT_GIT_BRANCH_STATUS='ahead'
            elif [[ $arr[2] =~ 'diverged' ]]; then
                __CURRENT_GIT_BRANCH_STATUS='diverged'
            # with git v2 the sentence "Your branch is" is always printed, not only if it has changes
            elif [[ $arr[2] =~ 'behind' ]]; then
                __CURRENT_GIT_BRANCH_STATUS='behind'
            fi
        fi

        if [[ ! $st =~ 'nothing to commit' ]]; then
            __CURRENT_GIT_BRANCH_IS_DIRTY='1'
        fi
    fi
}

git_custom_status() {
    update_current_git_vars
    if [ -n "$__CURRENT_GIT_BRANCH" ]; then
        # git prompt
        local gp=" - ["
        # status
        local s=""
        gp+="$__CURRENT_GIT_BRANCH"
        case "$__CURRENT_GIT_BRANCH_STATUS" in
            ahead)
            s+="↑"
            ;;
            diverged)
            s+="↕"
            ;;
            behind)
            s+="↓"
            ;;
        esac
        if [ -n "$__CURRENT_GIT_BRANCH_IS_DIRTY" ]; then
            #s+="⚡"
            s+="%{✚%G%}"
        fi
        if [ -n "$s" ]; then
            gp+=" %{$fg[red]%}"
            gp+=$s;
            gp+="%{$reset_color%}"
        else
            gp+=" %{$fg[green]%}%{✔%G%}%{$reset_color%}"
        fi
        gp+="]"

        printf "%s" $gp
    fi
}

if [[ $USER == "root" ]]; then
    PS1_PREFIX="%{$fg[red]%}%n%{$reset_color%}@"
elif [[ ( $USER != "meissner" ) && ( $USER != "mmeissner" ) ]]; then
    PS1_PREFIX="%{$fg[blue]%}%n%{$reset_color%}@"
else
    PS1_PREFIX=""
fi

PS1='[${PS1_PREFIX}%{$fg[blue]%}%m%{$reset_color%}:%{$fg[blue]%}%4c%{$reset_color%}]$(git_custom_status)
%(!.#.$) '
RPS1="%{$(echotc UP 1)%}(%D{%Y-%m-%d %H:%M:%S})%{$(echotc DO 1)%}"
#RPS1="$PR_BLUE(%D{%y-%m-%d %H:%M})$PR_NO_COLOR"
# %{$fg_bold[green]%}
