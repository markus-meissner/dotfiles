function lsof-tcp
    switch (uname | string lower)
        case freebsd openbsd dragonfly
            echo "sockstat -4 -l"
            sockstat -4 -l
        case linux
            echo "sudo lsof -nP -iTCP -sTCP:LISTEN"
            sudo lsof -nP -iTCP -sTCP:LISTEN
        case '*'
            echo -ns '?'
    end
end

