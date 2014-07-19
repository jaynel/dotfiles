set tabstop=4
set smartindent
set shiftwidth=4
set expandtab
set number          "row
"set ruler           "column
set showcmd         "Incomplete commands
"set showmode        "Shows mode
set hidden          "For multiple buffers
set ignorecase      "Search case sensitivity
set smartcase       "case-sensitive if expression contains capital
set scrolloff=3     "room of context around cursor
set backspace=indent,eol,start
syntax enable

" Needed for powerline
set laststatus=2

nnoremap <space> za

"For tab movement: 
nmap <C-H> :tabprev<CR>
nmap <C-L> :tabnext<CR>

"Better Saving
map <C-B> :wa<CR>
map! <C-W> <Esc>:wa<CR>
map! <C-J> <Esc>:wqa<CR>
map <C-X> :qa<CR>

set noswapfile
set nobackup

nnoremap ; :
set t_Co=256
set background=dark

python from powerline.vim import setup as powerline_setup
python powerline_setup()
python del powerline_setup
color solarized
