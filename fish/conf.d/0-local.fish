#echo 'LOAD "0-local.fish",8,1'

# https://github.com/jethrokuan/z/issues/104
set Z_DATA_DIR "$HOME/.local/share/z"
set Z_DATA "$Z_DATA_DIR/data"
set Z_EXCLUDE "^$HOME\$"

# We don't use tide any longer, only this (copied and modified) function
tide_detect_os | read -g --line os_branding_icon os_branding_color os_branding_bg_color os_branding_version

if test -n $os_branding_version
    # Add space for prompt
    set os_branding_version " $os_branding_version"
end

# https://fishshell.com/docs/current/cmds/fish_git_prompt.html
set -g __fish_git_prompt_show_informative_status 1
set -g __fish_git_prompt_showcolorhints 1
set -g __fish_git_prompt_showuntrackedfiles 1
set -g __fish_git_prompt_char_stateseparator ' '
set -g __fish_git_prompt_color_branch normal
set -g __fish_git_prompt_color_cleanstate green
set -g fish_color_cwd blue

# https://github.com/acomagu/fish-async-prompt
# We want the prompt_pwd to be instant, so only make the vcs prompt async
set async_prompt_functions fish_vcs_prompt

