function whatsmyip
    if command -q curl
        curl -s https://ip.meissner.it
    else
        wget -q -O - https://ip.meissner.it
    end
end
