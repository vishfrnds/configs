filetype off                  " required
syntax enable  	                		" Highlights syntax
set nocompatible              " be iMproved, required
set hidden				                " Multiple bufer, not abandoned, !q error
set nowrap                              " Display long lines as just one line
set iskeyword+=-                        " treat dash separated words as a word text object"
set encoding=utf-8                      " The encoding displayed
set pumheight=10                        " Makes popup menu smaller
set fileencoding=utf-8                  " The encoding written to file
set cmdheight=2                         " More space for displaying messages
set mouse=a                             " Enable your mouse
set splitbelow                          " Horizontal splits will automatically be below
set splitright                          " Vertical splits will automatically be to the right
set expandtab                           " Converts tabs to spaces
set smartindent                         " Makes indenting smart
set autoindent                          " Good auto indent
set number                              " Line numbers
set cursorline                          " Enable highlighting of the current line
set showtabline=2                       " Always show tabs
set noshowmode                          " We don't need to see things like -- INSERT -- anymore
set clipboard=unnamedplus               " Copy paste between vim and everything else
set incsearch	" search while typing
set background=dark                     " tell vim what the background color looks like
set t_Co=256                            " Support 256 colors
set relativenumber
set colorcolumn=+1 " heilight column after textwidth
set showmatch	" matching brackets

" use plugin for status
set laststatus=0
set noshowmode  " to get rid of thing like --INSERT--

" search
set hlsearch	" highlight all matches
set smartcase	" not case sens when all small
