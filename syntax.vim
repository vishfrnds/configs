syntax enable  	                		" Highlights syntax
set nocompatible                        " be iMproved, required
set hidden				                " Multiple bufer, not abandoned, !q error

" ================ Turn Off Swap Files ==============
set noswapfile
set nobackup
set nowb

set nowrap                              " Display long lines as just one line
" set iskeyword+=-                        " treat dash separated words as a word text object"
set encoding=utf-8                      " The encoding displayed
set pumheight=10                        " Makes popup menu smaller
set fileencoding=utf-8                  " The encoding written to file
" set cmdheight=2                         " More space for displaying messages
" set mouse=a                             " Enable your mouse
set splitbelow                          " Horizontal splits will automatically be below
set splitright                          " Vertical splits will automatically be to the right
set expandtab                           " Converts tabs to spaces
set smartindent                         " Makes indenting smart
set autoindent                          " Good auto indent
set number                              " Line numbers
set relativenumber
set cursorline                          " Enable highlighting of the current line
" set showtabline=2                       " Always show tabs
set clipboard=unnamedplus               " Copy paste between vim and everything else
set background=dark                     " tell vim what the background color looks like
" set t_Co=256                            " Support 256 colors
set ts=2                                " tab as 4 spaces
set colorcolumn=+1                      " heilight column after textwidth
set showmatch	                        " matching brackets

" use air line plugin for status
set laststatus=2
set noshowmode  " to get rid of thing like --INSERT--

" search
set incsearch	                        " search while typing
set hlsearch	                        " highlight all matches
set smartcase	                        " not case sens when all small
set ignorecase                          " req for smartcase to work

filetype plugin indent on

augroup quickfix
    autocmd!
    autocmd FileType qf setlocal wrap
augroup END

hi clear SignColumn
