let mapleader =";"

call plug#begin(system('echo -n "${XDG_CONFIG_HOME:-$HOME/.config}/nvim/plugged"'))

" Html/JSX stuff
Plug 'alvan/vim-closetag'
Plug 'yuezk/vim-js'
Plug 'leafgarland/typescript-vim'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'styled-components/vim-styled-components'

" Snippets
Plug 'honza/vim-snippets'

" Rust
Plug 'rust-lang/rust.vim'

Plug 'tpope/vim-endwise'
Plug 'tpope/vim-surround'

Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'preservim/nerdtree'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'jreybert/vimagit'
Plug 'lukesmithxyz/vimling'
Plug 'vimwiki/vimwiki'
Plug 'vim-airline/vim-airline'
Plug 'tpope/vim-commentary'
Plug 'ap/vim-css-color'
call plug#end()

" Rust
let g:rustfmt_autosave = 1

" FZF
nmap <C-P> :FZF<CR>

" CoC Stuff
" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-h> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

xmap <leader>a <Plug>(coc-codeaction-selected)
nmap <leader>a <Plug>(coc-codeaction-selected)

inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

nnoremap <slient> K :call  ShowDocumentation()<CR>

set title
set bg=light
set go=a
set mouse=a
set nohlsearch
set autoindent
set clipboard+=unnamedplus
set noshowmode
set noruler
set incsearch
set laststatus=0
set noshowcmd
set shiftwidth=2
set tabstop=2
set ai
set si

" Some basics:
	nnoremap c "_c
	set nocompatible
	filetype plugin indent on
	set omnifunc=csscomplete#CompleteCSS
	syntax on
	set encoding=utf-8
	set number relativenumber

" Enable autocompletion:
	set wildmode=longest,list,full

" Disables automatic commenting on newline:
	autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Perform dot commands over visual blocks:
	vnoremap . :normal .<CR>
" Splits open at the bottom and right, which is non-retarded, unlike vim defaults.
	set splitbelow splitright

" Folding
	set foldmethod=syntax
	set foldlevel=99

" Nerd tree
	map <leader>n :NERDTreeToggle<CR>
	autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
    if has('nvim')
        let NERDTreeBookmarksFile = stdpath('data') . '/NERDTreeBookmarks'
    else
        let NERDTreeBookmarksFile = '~/.vim' . '/NERDTreeBookmarks'
    endif

" Splits
	nmap ss :split<Return><C-w>w
	nmap sv :vsplit<Return><C-w>w

" vimling:
	nm <leader><leader>d :call ToggleDeadKeys()<CR>
	imap <leader><leader>d <esc>:call ToggleDeadKeys()<CR>a
	nm <leader><leader>i :call ToggleIPA()<CR>
	imap <leader><leader>i <esc>:call ToggleIPA()<CR>a
	nm <leader><leader>q :call ToggleProse()<CR>

" Shortcutting split navigation, saving a keypress:
	map <C-h> <C-w>h
	map <C-j> <C-w>j
	map <C-k> <C-w>k
	map <C-l> <C-w>l

" Replace all is aliased to S.
	nnoremap S :%s//g<Left><Left>

" Save file as sudo on files that require root permission
	cnoremap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!

" Automatically deletes all trailing whitespace and newlines at end of file on save. & reset cursor position
 	autocmd BufWritePre * let currPos = getpos(".")
	autocmd BufWritePre * %s/\s\+$//e
	autocmd BufWritePre * %s/\n\+\%$//e
	autocmd BufWritePre *.[ch] %s/\%$/\r/e
  autocmd BufWritePre * cal cursor(currPos[1], currPos[2])

" Turns off highlighting on the bits of code that are changed, so the line that is changed is highlighted but the actual text that has changed stands out on the line and is readable.
if &diff
    highlight! link DiffText MatchParen
endif

" Function for toggling the bottom statusbar:
let s:hidden_all = 0
function! ToggleHiddenAll()
    if s:hidden_all  == 0
        let s:hidden_all = 1
        set noshowmode
        set noruler
        set laststatus=0
        set noshowcmd
    else
        let s:hidden_all = 0
        set showmode
        set ruler
        set laststatus=2
        set showcmd
    endif
endfunction
nnoremap <leader>h :call ToggleHiddenAll()<CR>
" Load command shortcuts generated from bm-dirs and bm-files via shortcuts script.
" Here leader is ";".
" So ":vs ;cfz" will expand into ":vs /home/<user>/.config/zsh/.zshrc"
" if typed fast without the timeout.

" Filetypes
au BufNewFile,BufRead *.es6 setf javascript
au BufNewFile,BufRead *.tsx setf typescriptreact

set suffixesadd=.js,.es,.jsx,.css,.less,.sass,.styl,.php,.py,.md
