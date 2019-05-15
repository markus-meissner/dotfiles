#19964: zsh unter Synology DSM nutzen

[ -f /opt/etc/profile ] && . /opt/etc/profile

preferred_shell=
if [ -x "$(which zsh)" ]; then
    preferred_shell=$(which zsh)
fi

case $- in
    *i*)
        if [ -n "$preferred_shell" ]; then
            echo "[.profile]: Using $preferred_shell"
            SHELL=$preferred_shell; export SHELL; exec $preferred_shell -l
        else
            echo "[.profile]: zsh not found"
        fi
    ;;
esac

