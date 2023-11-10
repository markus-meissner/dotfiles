if not status is-interactive
    exit
end

if test ! -e ~/.local/share/fish/zsh-history-to-fish-imported
    python3 ~/.dotfiles/zsh-history-to-fish
    touch ~/.local/share/fish/zsh-history-to-fish-imported
end

