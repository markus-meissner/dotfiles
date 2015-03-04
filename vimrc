set paste
set ruler
" displaying line numbers is great but leads to problems (e.g. line numbers) 
" when doing copy/paste via mouse / terminal
"set nu
set tabstop=4 shiftwidth=4 expandtab
set sm
syntax on

" set background=light
set background=dark
colorscheme solarized

au BufRead,BufNewFile /etc/puppet/* set tabstop=2

if filereadable(glob("~/.vimrc.local")) 
    source ~/.vimrc.local
endif
