function tm -d "tail the system logs"
    # In previous versions $argv was appended to the command in order to tail
    # more files, e.g.
    # tm /var/log/zabbix/zabbix-agent.log
    # This leads to the problem that
    # tm | grep my-string
    # does not work.
    # → Perhaps abbr is a better solution.
    switch (uname | string lower)
        case darwin
            sudo tail -F /var/log/system.log /var/log/secure.log
        case dragonfly freebsd
            sudo tail -F /var/log/{auth.log,cron,daemon.log,security,messages}
        case openbsd
            sudo tail -f /var/log/{authlog,daemon,maillog,messages,secure}
        case linux
            switch (_detect_linux_flavor | string lower)
                case redhat
                    sudo tail -F /var/log/secure /var/log/cron /var/log/messages
                case '*'
                    if test -f /var/log/auth.log
                        sudo tail -F /var/log/auth.log /var/log/syslog
                    else
                        echo "Using journalctl"
                        journalctl -f
                    end
            end
        case '*'
            echo -ns '?'
    end
end
