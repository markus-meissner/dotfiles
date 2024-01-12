function lsphppoolsports
    egrep "^listen " /etc/php/*/fpm/pool.d/*.conf|awk "{print \$3;}"|sort
end
