function testmail
    echo | mail -s "Test von $(hostname) um $(date) " $argv
end
