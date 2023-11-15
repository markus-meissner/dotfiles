function iptables-la
    iptables-l -v $argv
    iptables-l -v -t nat $argv
end
