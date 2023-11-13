function tml
    sudo tail -F $(sudo find /var/log -name dovecot.log -o -name maillog -o -name mail.log)
end
    
