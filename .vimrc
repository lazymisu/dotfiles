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
set rtp+=/opt/homebrew/bin/fzf

let g:gruvbox_invert_selection='0'

let g:WhiplashProjectsDir = "~/Developer/"
let g:WhiplashConfigDir = "~/.vim/whiplash"

autocmd VimEnter * hi Normal ctermbg=NONE guibg=NONE

" tmux title update
autocmd BufEnter * call system("tmux rename-window  \"vim (" . expand("%:t") . ")\"")
autocmd VimLeave * call system("tmux rename-window fish")

call vundle#begin()
Plugin 'gmarik/Vundle.vim'
Plugin 'RRethy/vim-illuminate'
Plugin 'flazz/vim-colorschemes'
Plugin 'vim-airline/vim-airline'
Plugin 'morhetz/gruvbox'
Plugin 'tpope/vim-unimpaired'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-commentary'
Plugin 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plugin 'junegunn/fzf.vim'
Plugin 'machakann/vim-highlightedyank'
Plugin 'arkwright/vim-whiplash'
Plugin 'mg979/vim-visual-multi'
Plugin 'prabirshrestha/vim-lsp'
Plugin 'mattn/vim-lsp-settings'
Plugin 'prabirshrestha/asyncomplete.vim'
Plugin 'prabirshrestha/asyncomplete-lsp.vim'
call vundle#end()

" colorscheme Tomorrow-Night
colorscheme gruvbox

filetype plugin indent on

let g:highlightedyank_highlight_duration = 100

" SourceKit-LSP configuration
if executable('sourcekit-lsp')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'sourcekit-lsp',
        \ 'cmd': {server_info->['sourcekit-lsp']},
        \ 'whitelist': ['swift'],
        \ })
endif

function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    setlocal signcolumn=yes
    if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
    nmap <buffer> gd <plug>(lsp-definition)
    " nmap <buffer> gs <plug>(lsp-document-symbol-search)
    " nmap <buffer> gS <plug>(lsp-workspace-symbol-search)
    " nmap <buffer> gr <plug>(lsp-references)
    " nmap <buffer> gi <plug>(lsp-implementation)
    " nmap <buffer> gt <plug>(lsp-type-definition)
    nmap <buffer> <leader>rn <plug>(lsp-rename)
    nmap <buffer> [g <plug>(lsp-previous-diagnostic)
    nmap <buffer> ]g <plug>(lsp-next-diagnostic)
    nmap <buffer> K <plug>(lsp-hover)
    " nnoremap <buffer> <expr><c-f> lsp#scroll(+4)
    " nnoremap <buffer> <expr><c-d> lsp#scroll(-4)

    let g:lsp_format_sync_timeout = 1000
    autocmd! BufWritePre *.rs,*.go call execute('LspDocumentFormatSync')
    
    " refer to doc to add more commands
endfunction

augroup lsp_install
    au!
    " call s:on_lsp_buffer_enabled only for languages that has the server registered.
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END

nnoremap <Leader>pv  :Ex<CR>
nnoremap <Leader>o   :Files ~/Developer<CR>
nnoremap <Leader>F   :Rg<CR>
nnoremap <Leader>t   :GFiles<CR>
nnoremap <Leader>w   :w<CR>
nnoremap <Leader>Q   :q!<CR>
nnoremap <Leader>q   :q<CR>
nnoremap <Leader>k   :%bd<CR>

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

nnoremap <Leader>,   :e ~/.vimrc<CR>

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
