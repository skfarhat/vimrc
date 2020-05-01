" ------------------------------------------------------------------------------
" Sami Farhat
" vimrc
" ------------------------------------------------------------------------------
"
if v:version < 703
    finish
endif

" 1-Plugins {{{
if &compatible
  set nocompatible               " Be iMproved
endif


" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

"------------------------------------------------------------------------------
" General

Plug 'easymotion/vim-easymotion'
Plug 'tpope/vim-fugitive'                  " git plugin
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'airblade/vim-gitgutter'              " git-diff on the left-bar

Plug 'scrooloose/nerdcommenter'            " commenting
Plug 'ctrlpvim/ctrlp.vim'                  " fuzzy search
Plug 'bling/vim-airline'                   " cool status bar at the bottom
Plug 'vim-airline/vim-airline-themes'
Plug 'majutsushi/tagbar'                   " outline of the classes, functions (uses ctags)
Plug 'skfarhat/Tabmerge'                   " merge a tab to split
Plug 'jiangmiao/auto-pairs'                " auto-match parenthesis
Plug 'mileszs/ack.vim'                     " for grepping


" DISABLED "

" Plug 'mbbill/undotree'
" Plug 'haya14busa/incsearch.vim'            " better incremental search
" Plug 'haya14busa/incsearch-easymotion.vim' " intergration of inc search with vim-easymotion
" Plug 'matze/vim-move'                      " move lines up and down <A-j> <A-k>
" Plug 'godlygeek/tabular'
" Plug 'nacitar/a.vim'                       " switch between .h/.c files
" Plug 'drmikehenry/vim-headerguard'         " adds header guard to hpp
" Plug 'justinmk/vim-syntax-extra'           " c-improved syntax
" Plug 'tpope/vim-vinegar'
" Plug 'brookhong/cscope.vim'
" Plug 'skfarhat/cscope_maps'

"------------------------------------------------------------------------------
" Themes

Plug 'morhetz/gruvbox'
Plug 'dracula/vim'
Plug 'flazz/vim-colorschemes'
Plug 'chriskempson/base16-vim'

" You can specify revision/branch/tag.
" Plug 'Shougo/vimshell', { 'rev' : '3787e5' }

" Last disabled
" -------------
" Plug 'honza/vim-snippets'
" Plug 'SirVer/ultisnips'
" Plug 'lervag/vimtex'                       " Tex support
" Plug 'Shougo/neosnippet.vim'
" Plug 'Shougo/neosnippet-snippets'
" Plug 'scrooloose/nerdtree'                 " sidebar
" Plug 'Xuyuanp/nerdtree-git-plugin'         " show git status in NERDTree


" Initialize plugin system
call plug#end()

filetype plugin indent on
syntax enable

" -----------------------------------------------------------------------------

" }}}
" 2-General {{{

set wildmenu       " visual autocomplete for command menu
set showmatch      " highlight matching ({[]})            "
set showcmd        " shows commands written
set number         " show line numbers
set incsearch      " start searching as you're typing
set ignorecase     " make search case insensitive
set exrc           " allow per project configuration
set cscoperelative " remember to open the quickfix window to see the results :copen

" Spaces and Indents
syntax enable
set tabstop=2      " number of visual spaces per TAB
set softtabstop=2  " number of spaces in tab when editing
set shiftwidth=2
set expandtab      " tabs are spaces
set cursorline     " highlight current line


colorscheme monokai
set background=dark


if $TERM_PROGRAM =~ "iTerm"
  set termguicolors
endif


" better have the color change below after the theme
"set colorcolumn=80
" highlight ColorColumn ctermbg=8

" When the cursor is hold on a word, that word is highlighted.
" When the cursor is moving, the highlight is hidden
"set updatetime=1000
"au! CursorMoved * set nohlsearch
"au! CursorHold * set hlsearch | let @/='\<'.expand("<cword>").'\>'
"set hlsearch

highlight Cursor guifg=white guibg=black
highlight iCursor guifg=white guibg=steelblue

" }}}
" 3-Folding {{{
set foldenable      " enable folding
"foldlevelstart is the starting fold level for opening a new buffer. If it is set to 0, all folds will be closed.
"Setting it to 99 would guarantee folds are always open. So, setting it to 10 here ensures that only very nested
"blocks of code are folded when opening a buffer.
set foldlevelstart=10   "open most folds by default
set foldmethod=indent   "fold based on indent level
set foldopen=hor,mark,percent,quickfix,search,tag,undo " remove 'block' which unfolds when moving paragraphs
"}}}
" 4-Functions {{{

function! TrimWhitespace()
    let l:save = winsaveview()
    %s/\s\+$//e
    call winrestview(l:save)
endfun

function! EditVim()
   tabedit $HOME/.vimrc
endfunction

function! CppClass(classname)
  if (len(a:classname) == 0)
    echom "Empty Cpp class name not allowed."
    return
  let hpp=a:classname . '.hpp'
  let cpp=a:classname . '.cpp'
  execute 'tabe ' . fnameescape(hpp)
  execute 'vsplit ' . fnameescape(cpp)
endfunction

command! -nargs=* CreateCppClass :call CppClass(<q-args>)

"}}}
" 5-Key-Mapping{{{

let mapleader = " "
inoremap jk <esc>

imap <C-d> <C-[>diwi
nmap <C-d> <C-[>diw

nnoremap <leader>t :CtrlPTag<CR>

nmap <F8> :TagbarToggle<CR>
nmap <leader>ga Git "For GitGutter
nmap <leader>^ <C-^>
nmap <leader>ff :Ack

" EasyMotion
" disable default mappings
let g:EasyMotion_do_mapping = 0
nmap <leader>w <Plug>(easymotion-w)
nmap <leader>b <Plug>(easymotion-b)
nmap <leader>e <Plug>(easymotion-e)
nmap <leader>j <Plug>(easymotion-j)
nmap <leader>k <Plug>(easymotion-k)

" Tabularize
nmap <leader>a= :Tabularize /=<CR>
vmap <leader>a= :Tabularize /=<CR>
nmap <leader>a: :Tabularize /:\zs<CR>
vmap <leader>a: :Tabularize /:\zs<CR>
nmap <leader>a" :Tabularize /"<CR>
vmap <leader>a" :Tabularize /"<CR>

" YouCompleteMe
nnoremap <leader>g :YcmCompleter
" makes fixes to the code
nnoremap <leader>gf :YcmCompleter FixIt <CR>
" go to where that thing under the cursor is
nnoremap <leader>gg :YcmCompleter GoTo <CR>

" }}}
" 6-Plugin Options {{{

"------------------------------------------------------------
" vim-airline

"let g:airline_theme='dark'
let g:airline#extensions#tabline#enabled = 1
set laststatus=2
"------------------------------------------------------------
" AutoHeader

let g:autoHEADER_default_author="Sami Farhat"
let g:move_key_modifier = 'C'
"------------------------------------------------------------
" CtrlP

set wildignore+=*/build*/*,*/.git/*,*/trash/*,*/xcode*/*,*/docs/*,*/doxygen/*,*/bin/*,*/node_modules/*,*.o,*.pyc
let g:ctrlp_follow_symlinks = 1
let g:ctrlp_working_path_mode = 'aw'
" default should be to open in new tab
let g:ctrlp_prompt_mappings = {
      \     'AcceptSelection("e")': ['<c-t>'],
      \     'AcceptSelection("t")': ['<cr>', '<2-LeftMouse>'],
      \ }
" cscope
"------------------------------------------------------------
" Vim-flake
" Note: configuration for flake8 is system specific with a config file in
" ~/.config/flake8
" [flake8]
" max-line-length=120
"let g:flake8_max_line_length=120
"let g:flake8_ignore="E251,E221,E201,E202,E203"
"------------------------------------------------------------
" Vim-markdown

let g:markdown_enable_conceal=1
"------------------------------------------------------------
" Tabmerge

let g:Tabmerge_default_window_location= 'right' " acceptable values top|bottom|right|left
"------------------------------------------------------------
" Tagbar

let g:tagbar_sort = 0
"------------------------------------------------------------
" Vim-tex

" TODO: overrides the use of <F5> when in a .tex file
" TODO: resolve 'cannot use callbacks without +clientserver'
"------------------------------------------------------------
" YouCompleteMe

"let g:loaded_youcompleteme = 1
let g:ycm_add_preview_to_completeopt = 1                " ycm will add the function documentation in the list
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_confirm_extra_conf=0                          " don't look for .ycm-extra-conf
"------------------------------------------------------------
" JSHint2

let jshint2_save = 1
"------------------------------------------------------------

" For vim-headerguard to generate a header guard on creation of *.hpp or *.h
" files
autocmd BufNewFile *.hpp,*.h HeaderguardAdd

" clear trailing whitespace from source files
"autocmd BufWrite *.c,*.cpp,*.hpp,*.h,*.py,*.java,*.sh,*.txt,*.js call TrimWhitespace()

" }}}

" this tells vim the number of lines that it has to parse for file variables
" in this case, this file's first two and last two lines will be checked
set modelines=2
set secure "prevent unsafe commands in local vimrc
" ------------------------------------------------------------------------------
" vim:syntax=vim
" vim:foldmethod=marker:foldlevel=0
