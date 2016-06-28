set paste
set ruler
" displaying line numbers is great but leads to problems (e.g. line numbers) 
" when doing copy/paste via mouse / terminal
"set nu
" http://vim.wikia.com/wiki/Indenting_source_code
set shiftwidth=4 softtabstop=4
" To insert space characters whenever the tab key is pressed:
set expandtab
" Hint: Convert existing files according to your new settings:
" :retab
set sm
syntax on

" Let vim decide which background to use by setting / using COLORFGBG
" Use dark as default if not set
" #16824: vim: set background={light,dark} automatically based on terminal settings
if empty($COLORFGBG)
    " set background=light
    set background=dark
endif

colorscheme solarized

au BufRead,BufNewFile /etc/puppet/* set tabstop=2

if filereadable(glob("~/.vimrc.local")) 
    source ~/.vimrc.local
endif

" set mouse=a
" Try to show at least three lines and two columns of context when scrolling
set scrolloff=3
set sidescrolloff=2

" http://stackoverflow.com/questions/4390011/
set laststatus=2
set statusline=\ %F%m%r%h\ [%{&ff}]\ %y%=[col:%v,\ line:%l/%L\ (%p%%)]

