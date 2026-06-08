function tml -d "tail mail logs"
    switch (uname | string lower)
        case openbsd
            tail -f /var/log/maillog
        case '*'
            sudo tail -F $(sudo find /var/log -name dovecot.log -o -name maillog -o -name mail.log)
    end
end
