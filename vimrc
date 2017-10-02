" ------------------------------------------------------------------------------
" Sami Farhat
" vimrc
" ------------------------------------------------------------------------------
"
if v:version < 703
    finish
endif

" 1-Plugins {{{
"NeoBundle Scripts-----------------------------
if &compatible
  set nocompatible               " Be iMproved
endif
set runtimepath+=/home/sfarhat/.vim/bundle/neobundle.vim/
call neobundle#begin(expand('/home/sfarhat/.vim/bundle'))
NeoBundleFetch 'Shougo/neobundle.vim'
"------------------------------------------------------------------------------ 
" General 

NeoBundle 'easymotion/vim-easymotion'
NeoBundle 'tpope/vim-fugitive'                  " git plugin
NeoBundle 'tpope/vim-surround'
NeoBundle 'tpope/vim-repeat'
NeoBundle 'airblade/vim-gitgutter'              " git-diff on the left-bar
NeoBundle 'tpope/vim-vinegar'
NeoBundle 'scrooloose/nerdcommenter'            " commenting
NeoBundle 'ctrlpvim/ctrlp.vim'                  " fuzzy search
NeoBundle 'bling/vim-airline'                   " cool status bar at the bottom
NeoBundle 'vim-airline/vim-airline-themes'
NeoBundle 'majutsushi/tagbar'                   " outline of the classes, functions (uses ctags)
NeoBundle 'skfarhat/Tabmerge'                   " merge a tab to split 

NeoBundle 'nacitar/a.vim'                       " switch between .h/.c files 
NeoBundle 'drmikehenry/vim-headerguard'         " adds header guard to hpp
NeoBundle 'justinmk/vim-syntax-extra'           " c-improved syntax
NeoBundle 'jiangmiao/auto-pairs'                " auto-match parenthesis
NeoBundle 'mbbill/undotree'
NeoBundle 'mileszs/ack.vim'                     " for grepping
NeoBundle 'haya14busa/incsearch.vim'            " better incremental search
NeoBundle 'haya14busa/incsearch-easymotion.vim' " intergration of inc search with vim-easymotion
NeoBundle 'matze/vim-move'                      " move lines up and down <A-j> <A-k>
NeoBundle 'godlygeek/tabular'
NeoBundle 'honza/vim-snippets'
NeoBundle 'SirVer/ultisnips'
NeoBundle 'brookhong/cscope.vim'
NeoBundle 'skfarhat/cscope_maps'
"------------------------------------------------------------------------------ 
" Syntaxes 

NeoBundle 'Valloric/YouCompleteMe'  " C/C++ autocomplete
NeoBundle 'rdnetto/YCM-Generator'   " automatically generates ycm related flags
NeoBundle 'plasticboy/vim-markdown' " Markdown syntax
NeoBundle 'jansenm/vim-cmake'       " Cmake syntax
NeoBundle 'pangloss/vim-javascript' " javascript
NeoBundle 'Shutnik/jshint2.vim'
NeoBundle 'vim-scripts/matchit.zip'

"------------------------------------------------------------------------------ 
" Themes

NeoBundle 'dracula/vim'
NeoBundle 'flazz/vim-colorschemes'
NeoBundle 'chriskempson/base16-vim'

" You can specify revision/branch/tag.
NeoBundle 'Shougo/vimshell', { 'rev' : '3787e5' }

" Last disabled
" -------------
" NeoBundle 'lervag/vimtex'                       " Tex support
" NeoBundle 'Shougo/neosnippet.vim'
" NeoBundle 'Shougo/neosnippet-snippets'
" NeoBundle 'scrooloose/nerdtree'                 " sidebar
" NeoBundle 'Xuyuanp/nerdtree-git-plugin'         " show git status in NERDTree

" Required:
call neobundle#end()

" Required:
filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck
"End NeoBundle Scripts-------------------------

" }}}
" 2-General {{{

set wildmenu      " visual autocomplete for command menu
set showmatch     " highlight matching ({[]})            "
set showcmd       " shows commands written
set number        " show line numbers
set incsearch     " start searching as you're typing
"set cindent       " c-indentation standard
set ignorecase    " make search case insensitive
set exrc          " allow per project configuration

" Spaces and Indents
syntax enable
set tabstop=2     " number of visual spaces per TAB
set softtabstop=2 " number of spaces in tab when editing
set shiftwidth=2
set expandtab     " tabs are spaces
set cursorline    " highlight current line

colorscheme hybrid
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

" jk is escape
inoremap jk <esc>

" press // on the visually selected text to search for its next occurence
vnoremap // y/<C-R>"<CR> 

imap <C-d> <C-[>diwi
nmap <C-d> <C-[>diw

nmap :a :A

" easier to drop the shift
nmap ; :

nnoremap <leader>t :CtrlPTag<CR>

nmap <F8> :TagbarToggle<CR>
nmap <leader>ga Git "For GitGutter
nmap <leader>^ <C-^>

" EasyMotion
" disable default mappings
let g:EasyMotion_do_mapping = 0 
nmap <leader>w <Plug>(easymotion-w)
nmap <leader>b <Plug>(easymotion-b)
nmap <leader>e <Plug>(easymotion-e)
nmap <leader>j <Plug>(easymotion-j)
nmap <leader>k <Plug>(easymotion-k)


" to change colorschemes
nnoremap <F10> :call NextColor(-1)<CR>
nnoremap <F11> :call NextColor(0)<CR>
nnoremap <F12> :call NextColor(1)<CR>

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

set wildignore+=*/build*/*,*/.git/*,*/trash/*,*/xcode*/*,*/docs/*,*/doxygen/*,*/bin/*,*/node_modules/*,*.o
let g:ctrlp_follow_symlinks = 1
" 'rw' " this is generally good for projects with (.git .hg ...) 
let g:ctrlp_working_path_mode = 'aw'
" default should be to open in new tab
let g:ctrlp_prompt_mappings = {
      \     'AcceptSelection("e")': ['<c-t>'],
      \     'AcceptSelection("t")': ['<cr>', '<2-LeftMouse>'],
      \ }
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
" UltiSnip

let g:UltiSnipsExpandTrigger="<leader><tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
let g:UltiSnipsEditSplit="vertical"
"------------------------------------------------------------
" JSHint2 

let jshint2_save = 1
"------------------------------------------------------------

" For vim-headerguard to generate a header guard on creation of *.hpp or *.h
" files
autocmd BufNewFile *.hpp,*.h HeaderguardAdd

" clear trailing whitespace from source files
autocmd BufWrite *.c,*.cpp,*.hpp,*.h,*.py,*.java,*.sh,*.txt,*.js call TrimWhitespace()

" }}}

" this tells vim the number of lines that it has to parse for file variables
" in this case, this file's first two and last two lines will be checked 
set modelines=2
set secure "prevent unsafe commands in local vimrc

" ------------------------------------------------------------------------------
" Notes: 
"
"
" filetype plugin indent on
" Notes
" to override some of the mappings introduced by some plugins, directories
" with the path ~/.vim/after/plugin/the_plugin_name_here.vim, should be
" created.

" Tips
" select a word in visual mode: vaw

" Last 2 lines:
" last line is processed by vim and it must be at the end of the file it is worth mentioning 
" that a space in between '"' and 'vim' is needed in the below line.
" ------------------------------------------------------------------------------
" vim:syntax=vim
" vim:foldmethod=marker:foldlevel=0
