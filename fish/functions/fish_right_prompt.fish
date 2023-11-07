function fish_right_prompt -d "Write out the right prompt"
    # https://github.com/fish-shell/fish-shell/issues/3476#issuecomment-256058730
    tput sc; tput cuu1; tput cuf 2
    date '+%Y-%m-%d %H:%M:%S'
    tput rc
end
