function lssites
    if test -n "$(find /etc -mindepth 2 -maxdepth 2 -name sites-enabled -type d 2>/dev/null)"
        set --append sites $(find /etc/*/sites-enabled/ -type l)
    end
    set --append sites $(find /etc/nginx/conf.d/ -type f -name "server-*.conf")
    echo $sites | xargs ls -l
end

