function lsof-tcp
    switch (uname | string lower)
        case freebsd dragonfly
            echo "sockstat -4 -l"
            sockstat -4 -l
        case openbsd
            echo "netstat -an -f inet | grep LISTEN"
            netstat -an -f inet | grep LISTEN
        case linux
            echo "sudo lsof -nP -iTCP -sTCP:LISTEN"
            sudo lsof -nP -iTCP -sTCP:LISTEN
        case '*'
            echo -ns '?'
    end
end

