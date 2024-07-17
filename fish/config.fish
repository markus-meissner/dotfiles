if status is-interactive
    # https://fishshell.com/docs/current/index.html#configuration
    # .fish scripts in ~/.config/fish/conf.d/ are also automatically executed before config.fish.
    # -> see conf.d/0-local.fish for details

    set -gx PATH $PATH ~/.local/bin ~/bin
    [ -d /opt/homebrew/bin ] && set -gx PATH $PATH /opt/homebrew/bin

    if command -q vim
        alias vi=vim
        set -gx EDITOR $(which vim)
    end

    # https://fishshell.com/docs/current/tutorial.html#conditionals-if-else-switch
    if command -q less; and test "$(uname | string lower)" != "openbsd"
        # 2024-07-17: Removed -X as I don't know if we need it
        alias less='less --quit-if-one-screen'
    else
        # There is an unknown bug at MMs iTerm making less scrolling
        # wildly, so simply use more on OpenBSD
        # On OpenBSD more only supports -e, not --quit-at-eof
        alias less='more -e'
    end

    abbr -a -- du-hs 'sudo du -hs * | sort -h'
    abbr -a -- ff 'find . -name'

    # https://unix.stackexchange.com/a/176331
    function setenv; set -gx $argv; end
    if test -e ~/.env
        source ~/.env
    end

    # FreeBSD has /home linked to /usr/home, this leads to
    # a prompt showing /usr/home/user instead of ~
    if test $PWD != $HOME -a (readlink -f $HOME) = $PWD
        cd
    end
end

