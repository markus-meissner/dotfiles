set paste
set ruler
set nu
set tabstop=4 shiftwidth=4 expandtab
set sm
syntax on

set background=light
colorscheme solarized

au BufRead,BufNewFile /etc/puppet/* set tabstop=2

if filereadable(glob("~/.vimrc.local")) 
    source ~/.vimrc.local
endif
