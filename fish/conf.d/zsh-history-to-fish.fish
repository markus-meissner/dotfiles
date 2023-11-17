if not status is-interactive
    exit
end

if test ! -e ~/.local/share/fish/zsh-history-to-fish-imported
    if test -e ~/.zhistory
        python3 ~/.dotfiles/zsh-history-to-fish
    end
    touch ~/.local/share/fish/zsh-history-to-fish-imported
end

