function tm -d "tail the system logs"
    switch (uname | string lower)
        case darwin
            sudo tail -F /var/log/system.log /var/log/secure.log
        case freebsd openbsd dragonfly
            sudo tail -F /var/log/auth.log /var/log/cron /var/log/security /var/log/messages
        case linux
            switch (_detect_linux_flavor | string lower)
                case redhat
                    sudo tail -F /var/log/secure /var/log/cron /var/log/messages
                case '*'
                    sudo tail -F /var/log/auth.log /var/log/syslog
            end
        case '*'
            echo -ns '?'
    end
end

