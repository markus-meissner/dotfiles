function lssockets-tcp
    switch (uname | string lower)
        case freebsd
            echo "sockstat -4 -l"
            sockstat -4 -l
        case openbsd
            echo "netstat -an -f inet | grep LISTEN"
            netstat -an -f inet | grep LISTEN
        case linux
            echo "sudo ss -tlnp"
            sudo ss -tlnp
        case '*'
            echo -ns '?'
    end
end
