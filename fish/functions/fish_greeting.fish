function fish_greeting
    if functions -q fish_is_root_user; and fish_is_root_user
        echo "No selfupdate as user root, call ~/.dotfiles/selfupdate manually if needed"
    else if test -f ~/.dotfiles/.selfupdate-disabled
        echo "Selfupdate has been disabled, call ~/.dotfiles/selfupdate manually if needed"
    else
        ~/.dotfiles/selfupdate
    end

    if which git >/dev/null 2>&1
        echo "Markus dotfiles v$(cd ~/.dotfiles; git log -n1 --pretty=format:"%ad" --date=short)"
    else
        echo "Markus dotfiles - no git, no version"
    end
end

