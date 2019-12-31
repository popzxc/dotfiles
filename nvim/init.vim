" Note for the future myself:
" 1. Obtain neovim (https://github.com/neovim/neovim).
" 2. Obtain vim-pack (https://github.com/junegunn/vim-plug).
" 3. Compile `universal-ctags` from source -- `snap` package currently don't work with `tagbar` (https://github.com/universal-ctags/ctags).
" 4. Don't forget to launch `:PlugInstall` on first launch!

filetype on

" Plugins
" =======

call plug#begin(stdpath('data') . '/plugged')

Plug 'vim-airline/vim-airline'                                    " bottom status bar
Plug 'vim-airline/vim-airline-themes'                             " themes for vim-airline
Plug 'scrooloose/nerdtree'                                        " folders tree
Plug 'itchyny/lightline.vim'                                      " configurable status line (can be used by coc)
Plug 'airblade/vim-gitgutter'                                     " Git diffs in gutter
Plug 'mg979/vim-visual-multi'                                     " Multiple cursors selection
Plug 'sickill/vim-monokai'                                        " Monokai theme for vim
Plug 'tpope/vim-fugitive'                                         " Git manager
Plug 'tpope/vim-commentary'                                       " Commenting & uncommenting

" Autocomplete
Plug 'roxma/nvim-yarp'                                            " Needed for deoplete
Plug 'roxma/vim-hug-neovim-rpc'                                   " Needed for deoplete
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }     " Autocompletion

" Rust
Plug 'dense-analysis/ale'                                         " Syntax checking plugin (async instead of syntastic)
Plug 'majutsushi/tagbar'                                          " Browser for tags within file
Plug 'rust-lang/rust.vim'                                         " Rust lang support

" Haskell
Plug 'alx741/vim-stylishask'                                      " Call stylish-haskell on file save

" Possibly useful plugins
"Plug 'scrooloose/nerdcommenter'                                   " code commenter

call plug#end()

" End of plugins here
" ===================

" deoplete
" ========

let g:deoplete#enable_at_startup = 1

" airline: status bar at the bottom
" =================================

let g:airline_powerline_fonts=1

let g:airline#extensions#tabline#formatter = 'unique_tail_improved'

let g:airline_section_error = '%{airline#util#wrap(airline#extensions#coc#get_error(),0)}'
let g:airline_section_warning = '%{airline#util#wrap(airline#extensions#coc#get_warning(),0)}'

" Nerd commenter
" ==============
filetype plugin on

" Better Unix support
" ===================
set viewoptions=folds,options,cursor,unix,slash
set encoding=utf-8

" On save
" =======

" Haskell on-save config.
function! TrimWhitespace()
    let l:save_cursor = getpos('.')
    %s/\s\+$//e
    call setpos('.', l:save_cursor)
endfun

command! TrimWhitespace call TrimWhitespace() " Trim whitespace with command
" autocmd BufWritePre * :call TrimWhitespace()  " Trim whitespace on every save
" autocmd InsertLeave * write                   " Save buffer automatically on leaving insert mode

augroup format-haskell
    autocmd!
    autocmd InsertLeave *.hs call stylishask#StylishaskOnSave()
    autocmd InsertLeave * :call TrimWhitespace()  " Trim whitespace on every save
    autocmd InsertLeave * write                   " Save buffer automatically on leaving insert mode
augroup END

" Rust config
" ===========

" Run rustfmt on save.
let g:rustfmt_autosave = 1

" Ale config
" ==========

" General

let g:ale_open_list = 'on_save' " Open list of warnings/errors on save

" For Rust

" Check tests
let g:ale_rust_cargo_check_tests = 1
" Use clippy instead of cargo
let g:ale_rust_cargo_use_clippy = executable('cargo-clippy')

" For Python

" Activate venv automatically
let g:ale_python_auto_pipenv = 1

" Use black
let g:ale_python_black_use_global = 1
let g:ale_python_black_options = '--line-length 120'

" Use mypy
let g:ale_python_mypy_use_global = 1
let g:ale_python_mypy_options = '--ignore-missing-imports --disallow-untyped-defs --follow-imports=silent'

" Use pylint
let g:ale_python_pylint_executable = 1
let g:ale_python_pylint_options = '--max-line-length=120 --disable=bad-continuation,too-few-public-methods'


" Tagbar config
" =============

let g:tagbar_show_linenumbers = 1
nmap <F8> :TagbarToggle<CR>

" NerdTree config
" ===============
let NERDTreeShowHidden = 1    " Show hidden files
let g:NERDTreeDirArrows = 1

" Open NerdTree on vim by default
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" Open NerdTree as tree explorer for folders by default
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif

" Shortcut for NerdTree (ctrl+alt+n)
noremap <C-A-n> :NERDTreeToggle<CR>

" Other options
" =============

syntax on
colorscheme monokai
set shell=/bin/zsh

" Turn off backup
set nobackup
set noswapfile
set nowritebackup

" Automatically change working directory to the currently edited file one.
set autochdir

" Auto wrap options
set formatoptions=qnlj  " convenient wrapping options
set textwidth=120       " wrap on 120 chars

" Other editor options
set laststatus=2            " Always use status line
set noshowmode              " Disable displaying of current mode (it's clear from the cursor shape)
set hidden                  " Hide files when leaving them.
set number                  " Show line numbers.
set numberwidth=1           " Minimum line number column width.
set cmdheight=2             " Number of screen lines to use for the commandline.
set linebreak               " Don't cut lines in the middle of a word.
set showmatch               " Shows matching parenthesis.
set matchtime=2             " Time during which the matching parenthesis is shown.
set listchars=tab:▸\ ,eol:¬ " Invisible characters representation when :set list.
set clipboard=unnamedplus   " Copy/Paste to/from clipboard (use '+' as target buffer)
set cursorline              " Highlight line cursor is currently on
set completeopt+=noinsert   " Select the first item of popup menu automatically without inserting it

" Fancy highlight of the current line
hi CursorLine term=bold cterm=bold guibg=Grey40

" Highlighting overrides for monokai style
hi SpellCap term=bold cterm=bold ctermfg=58 guifg=#5f5f00 "rgb=95,95,0 (Dark orange)
hi SpellBad term=bold cterm=bold ctermbg=52 guibg=#5f0000 "rgb=95,0,0 (Dark red)

" More natural screen splittin
set splitbelow
set splitright

" Search
set incsearch  " Incremental search.
set ignorecase " Case insensitive.
set smartcase  " Case insensitive if no uppercase letter in pattern, case sensitive otherwise.
set nowrapscan " Don't go back to first match after the last match is found.

" Tabs
set expandtab     " Tab transformed in spaces
set tabstop=4     " Sets tab character to correspond to x columns.
                  " x spaces are automatically converted to <tab>.
                  " If expandtab option is on each <tab> character is converted to x spaces.
set softtabstop=4 " column offset when PRESSING the tab key or the backspace key.
set shiftwidth=4  " column offset when using keys '>' and '<' in normal mode.

" Toggle display of tabs and EOF
nnoremap <leader>l :set list!<CR>

" Disable arrow keys and page up / down (use hjkl, baka!)
noremap <Up> <nop>
noremap <Down> <nop>
noremap <Left> <nop>
noremap <Right> <nop>
inoremap <Up> <nop>
inoremap <Down> <nop>
inoremap <Left> <nop>
inoremap <Right> <nop>
vnoremap <Up> <nop>
vnoremap <Down> <nop>
vnoremap <Left> <nop>
vnoremap <Right> <nop>
" The following should be uncommented later
" noremap <PageUp> <nop>
" inoremap <PageUp> <nop>
" vnoremap <PageUp> <nop>
" noremap <PageDown> <nop>
" inoremap <PageDown> <nop>
" vnoremap <PageDown> <nop>

" Disable mouse / touchpad (only in vim)
set mouse=nicr
inoremap <ScrollWheelUp> <nop>
inoremap <S-ScrollWheelUp> <nop>
inoremap <C-ScrollWheelUp> <nop>
inoremap <ScrollWheelDown> <nop>
inoremap <S-ScrollWheelDown> <nop>
inoremap <C-ScrollWheelDown> <nop>
inoremap <ScrollWheelLeft> <nop>
inoremap <S-ScrollWheelLeft> <nop>
inoremap <C-ScrollWheelLeft> <nop>
inoremap <ScrollWheelRight> <nop>
inoremap <S-ScrollWheelRight> <nop>
inoremap <C-ScrollWheelRight> <nop>
