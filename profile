#19964: zsh unter Synology DSM nutzen

[ -f /opt/etc/profile ] && . /opt/etc/profile

preferred_shell=
if [ -x $(which zsh) ]; then
    preferred_shell=$(which zsh)
fi
if [ -n "$preferred_shell" ]; then
  case $- in
    *i*) SHELL=$preferred_shell; export SHELL; exec $preferred_shell -l;;
  esac
fi

