function _detect_linux_flavor -d "Detect the linux flavor like debian or redhat, returns an empty string if unknown"
    set file /etc/os-release
    test -e $file || return
    set -l split_file (string split '=' <$file)
    set -l key_index (contains --index "ID" $split_file) || return
    return (string trim --chars='"' $split_file[(math $key_index + 1)])
end

