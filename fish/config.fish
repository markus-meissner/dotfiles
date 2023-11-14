if status is-interactive
    # Commands to run in interactive sessions can go here
    
    # https://fishshell.com/docs/current/index.html#configuration
    # .fish scripts in ~/.config/fish/conf.d/ are also automatically executed before config.fish.
    # -> see conf.d/0-local.fish for details

    set -gx PATH $PATH ~/.local/bin ~/bin
    [ -d /opt/homebrew/bin ] && set -gx PATH $PATH /opt/homebrew/bin

    set -gx EDITOR $(which vim)

    # https://unix.stackexchange.com/a/176331
    function setenv; set -gx $argv; end
    if test -e ~/.env
        source ~/.env
    end
end

