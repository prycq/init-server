" Configured by init-server script

" Show line numbers
set number

" Show status bar
set laststatus=2

" Automaticaly wrap text
set wrap

" Set colorscheme
colorscheme torte

" Show lines command
command! Non set number

" Hide lines command
command! Noff set nonumber

" Set status line colors
hi StatusLine ctermfg=white ctermbg=red

" Set TAB size
:set tabstop=4