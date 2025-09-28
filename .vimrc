"++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
"                                                                              "
"                       __   _ _ _ __ ___  _ __ ___                            "
"                       \ \ / / | '_ ` _ \| '__/ __|                           "
"                        \ V /| | | | | | | | | (__                            "
"                         \_/ |_|_| |_| |_|_|  \___|                           "
"                                                                              "
"                                                                              "
"++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"

set nocompatible              " be iMproved, required
filetype off                  " required
set hidden

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
"-------------------=== Code/Project navigation ===-------------
Plugin 'scrooloose/nerdtree'                " Project and file navigation
Plugin 'majutsushi/tagbar'                  " Class/module browser
Plugin 'kien/ctrlp.vim'                     " Fast transitions on project files

"-------------------=== Other ===-------------------------------
Plugin 'bling/vim-airline'                  " Lean & mean status/tabline for vim
Plugin 'vim-airline/vim-airline-themes'     " Themes for airline
" Plugin 'Lokaltog/powerline'                "Powerline fonts plugin
Plugin 'itchyny/lightline.vim'              " Powerline alternative
Plugin 'mengelbrecht/lightline-bufferline'  " Lightline multiple buffers
Plugin 'fisadev/FixedTaskList.vim'          " Pending tasks list
Plugin 'rosenfeld/conque-term'              " Consoles as buffers
Plugin 'voldikss/vim-floaterm'              " for lazygit
Plugin 'tpope/vim-surround'                 " Parentheses, brackets, quotes, XML tags, and more

"-------------------=== ColorSchemes ===-------------------------------
Plugin 'flazz/vim-colorschemes'             " Colorschemes
Plugin 'joshdick/onedark.vim'               " onedark
Plugin 'dracula/vim'                        " dracula
" Plugin 'mirodark/mirodark'                  " mirodark

"-------------------=== Snippets support ===--------------------
Plugin 'garbas/vim-snipmate'                " Snippets manager
Plugin 'MarcWeber/vim-addon-mw-utils'       " dependencies #1
Plugin 'tomtom/tlib_vim'                    " dependencies #2
Plugin 'honza/vim-snippets'                 " snippets repo

"-------------------=== Languages support ===-------------------
Plugin 'tpope/vim-commentary'               " Comment stuff out
Plugin 'mitsuhiko/vim-sparkup'              " Sparkup(XML/jinja/htlm-django/etc.) support
Plugin 'Rykka/riv.vim'                      " ReStructuredText plugin
" Plugin 'Valloric/YouCompleteMe'             " Autocomplete plugin

"-------------------=== Python  ===-----------------------------
" Plugin 'klen/python-mode'                   " Python mode (docs, refactor, lints...)
Plugin 'scrooloose/syntastic'               " Syntax checking plugin for Vim

call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

filetype on
filetype plugin on
filetype plugin indent on

"=====================================================
"" General settings
"=====================================================
syntax on                                   " syntax highlight

set t_Co=256                                " set 256 colors
set noshowmode                              " disable native vim mode since linghtline shows the mode
" let g:mirodark_enable_higher_contrast_mode=0
" nnoremap <Leader>m :MirodarkToggleHigherContrastMode<CR>

let g:lightline = {
  \ 'colorscheme': 'one',
  \ 'active': {
  \   'left': [ [ 'mode', 'paste' ], [ 'readonly', 'filename', 'modified' ] ]
  \ },
  \ 'tabline': {
  \   'left': [ ['buffers'] ],
  \   'right': [ ['close'] ]
  \ },
  \ 'component_expand': {
  \   'buffers': 'lightline#bufferline#buffers'
  \ },
  \ 'component_type': {
  \   'buffers': 'tabsel'
  \ }
  \ }

colorscheme mirodark                        " set color scheme

set number                                  " show line numbers
set ruler
set ttyfast                                 " terminal acceleration

set tabstop=4                               " 4 whitespaces for tabs visual presentation
set shiftwidth=4                            " shift lines by 4 spaces
set smarttab                                " set tabs for a shifttabs logic
set expandtab                               " expand tabs into spaces
set autoindent                              " indent when moving to the next line while writing code

set cursorline                              " shows line under the cursor's line
set showmatch                               " shows matching part of bracket pairs (), [], {}

set enc=utf-8                               " utf-8 by default

set nobackup                                " no backup files
set nowritebackup                           " only in case you don't want a backup file while editing
set noswapfile                              " no swap files

set backspace=indent,eol,start              " backspace removes all (indents, EOLs, start) What is start?

set scrolloff=10                            " let 10 lines before/after cursor during scroll

set clipboard=unnamed                       " use system clipboard

set exrc                                    " enable usage of additional .vimrc files from working directory
set secure                                  " prohibit .vimrc files to execute shell, create files, etc...

" Additional mappings for Esc (useful for MacBook with touch bar)
inoremap jj <Esc>
inoremap jk <Esc>

"=====================================================
"" Tabs / Buffers settings
"=====================================================
tab sball
set switchbuf=useopen
set laststatus=2
nmap <F9> :bprev<CR>
nmap <F10> :bnext<CR>
nmap <silent> <leader>q :SyntasticCheck # <CR> :bp <BAR> bd #<CR>

"" Search settings
"=====================================================
set incsearch                            " incremental search
set hlsearch                             " highlight search results

"=====================================================
"" AirLine settings
"=====================================================
let g:airline_theme='badwolf'
let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#tabline#formatter='unique_tail'
let g:airline_powerline_fonts=0

"=====================================================
"" TagBar settings
"=====================================================
let g:tagbar_autofocus=0
let g:tagbar_width=42
autocmd BufEnter *.py :call tagbar#autoopen(0)

"=====================================================
"" NERDTree settings
"=====================================================
let NERDTreeIgnore=['\.pyc$', '\.pyo$', '__pycache__$']     " Ignore files in NERDTree
let NERDTreeWinSize=30
autocmd VimEnter * if !argc() | NERDTree | endif  " Load NERDTree only if vim is run without arguments
nmap " :NERDTreeToggle<CR>

"=====================================================
"" SnipMate settings
"=====================================================
let g:snippets_dir=$vimhome.'/bundle/vim-snippets/snippets'
let g:snipMate = {'snippet_version' : 1}

"=====================================================
"" Riv.vim settings
"=====================================================
let g:riv_disable_folding=1

"=====================================================
"" MSVC C/C++ Compilation settings
"=====================================================

" Set default architecture (x64 for 64-bit, x86 for 32-bit)
let g:msvc_arch = 'x64'

" Function to run shell.bat and show output in quickfix
function! CompilationMode()
    " Save the current file first
    write

    " Check if build.bat exists in current directory
    if !filereadable('build.bat')
        echo "build.bat not found in current directory"
        return
    endif

    " Run build.bat and capture output into quickfix
    let output = system('build.bat')
    cgetexpr split(output, '\n')

    " Open quickfix window at bottom
    copen 20

    " Jump back to the source window
    " wincmd p
endfunction

augroup msvc_bindings
    autocmd!
    "autocmd FileType c,cpp nnoremap <buffer> <F5> :call CompilationMode()<CR>
    autocmd FileType c,cpp nnoremap <buffer> <M-m> :call CompilationMode()<CR>
augroup END

nnoremap <F12> :!start c:\raddbg\raddbg.exe<CR><CR>
nnoremap <M-,> :cclose<CR>

" Map leader+lg to open lazygit in a split terminal
nnoremap <leader>lg :FloatermNew lazygit<CR>

" General floaterm settings
let g:floaterm_width = 0.9
let g:floaterm_height = 0.9
let g:floaterm_position = 'center'

" Enhanced error format for MSVC
set errorformat=%f(%l\\,%c):\ %t%*[^:]:\ %m,%f(%l)\ :\ %t%*[^:]:\ %m

" Add AsyncRun plugin for non-blocking compilation (optional but recommended)
" Add this to your Vundle section if you want non-blocking compilation:
" Plugin 'skywind3000/asyncrun.vim'
"=====================================================
"" Python settings
"=====================================================
"
"" python executables for different plugins
"let g:pymode_python='python3'
"let g:syntastic_python_python_exec='python3'
"
"" rope
"let g:pymode_rope=0
"let g:pymode_rope_completion=0
"let g:pymode_rope_complete_on_dot=0
"let g:pymode_rope_auto_project=0
"let g:pymode_rope_enable_autoimport=0
"let g:pymode_rope_autoimport_generate=0
"let g:pymode_rope_guess_project=0
"
"" documentation
"let g:pymode_doc=0
"let g:pymode_doc_bind='K'
"
"" lints
"let g:pymode_lint=0
"
"" virtualenv
"let g:pymode_virtualenv=1
"
"" breakpoints
"let g:pymode_breakpoint=1
"let g:pymode_breakpoint_key='<leader>b'
"
"" syntax highlight
"let g:pymode_syntax=1
"let g:pymode_syntax_slow_sync=1
"let g:pymode_syntax_all=1
"let g:pymode_syntax_print_as_function=g:pymode_syntax_all
"let g:pymode_syntax_highlight_async_await=g:pymode_syntax_all
"let g:pymode_syntax_highlight_equal_operator=g:pymode_syntax_all
"let g:pymode_syntax_highlight_stars_operator=g:pymode_syntax_all
"let g:pymode_syntax_highlight_self=g:pymode_syntax_all
"let g:pymode_syntax_indent_errors=g:pymode_syntax_all
"let g:pymode_syntax_string_formatting=g:pymode_syntax_all
"let g:pymode_syntax_space_errors=g:pymode_syntax_all
"let g:pymode_syntax_string_format=g:pymode_syntax_all
"let g:pymode_syntax_string_templates=g:pymode_syntax_all
"let g:pymode_syntax_doctests=g:pymode_syntax_all
"let g:pymode_syntax_builtin_objs=g:pymode_syntax_all
"let g:pymode_syntax_builtin_types=g:pymode_syntax_all
"let g:pymode_syntax_highlight_exceptions=g:pymode_syntax_all
"let g:pymode_syntax_docstrings=g:pymode_syntax_all
"
"" highlight 'long' lines (>= 80 symbols) in python files
"augroup vimrc_autocmds
"    autocmd!
"    autocmd FileType python,rst,c,cpp highlight Excess ctermbg=DarkGrey guibg=Black
"    autocmd FileType python,rst,c,cpp match Excess /\%81v.*/
"    autocmd FileType python,rst,c,cpp set nowrap
"    autocmd FileType python,rst,c,cpp set colorcolumn=80
"augroup END
"
"" code folding
"let g:pymode_folding=0
"
"" pep8 indents
"let g:pymode_indent=1
"
"" code running
"let g:pymode_run=1
"let g:pymode_run_bind='<F5>'
"
"" syntastic
"let g:syntastic_always_populate_loc_list=1
"let g:syntastic_auto_loc_list=1
"let g:syntastic_enable_signs=1
"let g:syntastic_check_on_wq=0
"let g:syntastic_aggregate_errors=1
"let g:syntastic_loc_list_height=5
"let g:syntastic_error_symbol='X'
"let g:syntastic_style_error_symbol='X'
"let g:syntastic_warning_symbol='x'
"let g:syntastic_style_warning_symbol='x'
"let g:syntastic_python_checkers=['flake8', 'pydocstyle', 'python3']
"
"" YouCompleteMe
"set completeopt-=preview
"
"let g:ycm_global_ycm_extra_conf='~/.vim/ycm_extra_conf.py'
"let g:ycm_confirm_extra_conf=0
"
"nmap <leader>g :YcmCompleter GoTo<CR>
"nmap <leader>d :YcmCompleter GoToDefinition<CR>
set paste
