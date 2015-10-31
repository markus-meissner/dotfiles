set paste
set ruler
" displaying line numbers is great but leads to problems (e.g. line numbers) 
" when doing copy/paste via mouse / terminal
"set nu
" http://vim.wikia.com/wiki/Indenting_source_code
set shiftwidth=4 softtabstop=4
set sm
syntax on

" Let vim decide which background to use by setting / using COLORFGBG
" Use dark as default if not set
" http://www.sslug.dk/~chlor/vim-set-background-auto.html
if empty($COLORFGBG)
    " set background=light
    set background=dark
endif

colorscheme solarized

au BufRead,BufNewFile /etc/puppet/* set tabstop=2

if filereadable(glob("~/.vimrc.local")) 
    source ~/.vimrc.local
endif
