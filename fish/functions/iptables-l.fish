function iptables-l
    sudo iptables -n --line-numbers -L $argv
end
