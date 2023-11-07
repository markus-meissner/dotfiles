if status is-interactive
    # Commands to run in interactive sessions can go here
    
    # https://fishshell.com/docs/current/index.html#configuration
    # .fish scripts in ~/.config/fish/conf.d/ are also automatically executed before config.fish.
    # -> see conf.d/0-local.fish for details

    set -gx PATH $PATH ~/.local/bin ~/bin
    [ -d /opt/homebrew/bin ] && set -gx PATH $PATH /opt/homebrew/bin

    if command -q lsb_release; and test "$(lsb_release --short --release)" -eq 10
        # Don't set marker option in Debian 10
        echo "Debian 10, setting FZF_DEFAULT_OPTS"
        set --export FZF_DEFAULT_OPTS '--cycle --layout=reverse --border --height=90% --preview-window=wrap'
    end
end

