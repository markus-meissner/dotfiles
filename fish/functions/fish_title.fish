function fish_title
    # https://fishshell.com/docs/current/cmds/fish_title.html
    # https://github.com/glasserc/etc/blob/master/dot/config/fish/functions/fish_title.fish

    # Looks like ~/d/fish: git log
    # or /e/apt: fish
    set -q argv[1]; or set argv fish

    # prompt_login does not work here for unknown reasons
    if not set -q __fish_prompt_hostname
        set -g __fish_prompt_hostname (hostname|cut -d . -f 1)
    end

    echo -n -s "$__fish_prompt_hostname:"(fish_prompt_pwd_dir_length=1 prompt_pwd) " | " $argv;
end

