set hlsearch
set relativenumber
set number relativenumber
set incsearch
set ignorecase
set smartcase
set noshowmatch
set hidden
set noerrorbells
set linebreak

set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab

set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile

set mmp=500000

set so=4

filetype off
syntax on

let mapleader = " "

" set termguicolors

set t_Co=256
set background=dark
set updatetime=500

" Add Vundle to runtime path
set rtp+=~/.vim/bundle/Vundle.vim
set rtp+=~/usr/local/opt/fzf

let g:gruvbox_invert_selection='0'

let g:WhiplashProjectsDir = "~/Developer/"
let g:WhiplashConfigDir = "~/.vim/whiplash"

autocmd VimEnter * hi Normal ctermbg=NONE guibg=NONE

" tmux title update
autocmd BufEnter * call system("tmux rename-window  \"vim (" . expand("%:t") . ")\"")
autocmd VimLeave * call system("tmux rename-window fish")

call vundle#begin()
Plugin 'gmarik/Vundle.vim'
Plugin 'dense-analysis/ale'
Plugin 'RRethy/vim-illuminate'
Plugin 'flazz/vim-colorschemes'
Plugin 'vim-airline/vim-airline'
Plugin 'morhetz/gruvbox'
Plugin 'tpope/vim-unimpaired'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-commentary'
Plugin 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plugin 'junegunn/fzf.vim'
Plugin 'kien/rainbow_parentheses.vim'
Plugin 'machakann/vim-highlightedyank'
Plugin 'arkwright/vim-whiplash'
Plugin 'tpope/vim-obsession'
Plugin 'mg979/vim-visual-multi'
call vundle#end()

" colorscheme Tomorrow-Night
colorscheme gruvbox

filetype plugin indent on

let g:highlightedyank_highlight_duration = 100

function! s:loadsession(dir)
    exe 'cd ~/Developer/' . a:dir
    silent! source .vimsession
    exe 'cd ~/Developer/' . a:dir
endfunction

function! s:savesession()
    Obsess .vimsession
endfunction

if argc() == 0 | silent! source .vimsession | endif

nnoremap <silent> <Leader>o :call <sid>savesession()<CR>:silent call fzf#run({'source': 'ls ~/Developer/', 'options': '--reverse --prompt "Developer "', 'down': 20, 'dir': '~/Developer/', 'sink': function('<sid>loadsession') })<CR>
nnoremap <Leader>e   :ALENextWrap<CR>
nnoremap <Leader>F   :Rg
nnoremap <Leader>t   :GFiles<CR>
nnoremap <Leader>w   :w<CR>
nnoremap <Leader>Q   :q!<CR>
nnoremap <Leader>q   :call <sid>savesession()<CR>:q<CR>
nnoremap <Leader>k   :%bd<CR>

nnoremap <leader>p "+p

nmap <PageUp> <C-U>
nmap <PageDown> <C-D>

" Copy to clipboard
vnoremap  <leader>y  "+y
nnoremap  <leader>Y  "+yg_
nnoremap  <leader>y  "+y

" Paste from clipboard
nnoremap <leader>p "+p
nnoremap <leader>P "+P
vnoremap <leader>p "+p
vnoremap <leader>P "+P

nnoremap <Leader>,   :e ~/.vimrc<CR>:source ~/.vimrc<CR>

map <Leader>b :Buffers<CR>

" window navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

nnoremap <silent><Esc><Esc> :noh<CR>

" tab complete
inoremap <expr> <Tab> pumvisible() ? '<C-n>' :
            \ getline('.')[col('.')-2] =~# '[[:alnum:].-_#$]' ? '<C-x><C-o>' : '<Tab>'
