call plug#begin(stdpath('data').'/plugged')

Plug 'tpope/vim-vinegar'

" Shows formatting error warning on status bar
Plug 'vim-syntastic/syntastic'

Plug 'vim-scripts/indentpython.vim'

" <leader>c space
Plug 'preservim/nerdcommenter'

" status bar
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'


" Front
Plug 'davidhalter/jedi-vim'

"" https://github.com/google/vim-codefmt 
" Add maktaba and codefmt to the runtimepath.
" (The latter must be installed before it can be used.)
Plug 'google/vim-maktaba'
Plug 'google/vim-codefmt'
" Also add Glaive, which is used to configure codefmt's maktaba flags. See
" `:help :Glaive` for usage.
Plug 'google/vim-glaive'

Plug 'altercation/vim-colors-solarized'

Plug 'tpope/vim-fugitive'

Plug 'vim-test/vim-test'
call plug#end()

source ~/configs/plugins/syntastic.vim
source ~/configs/plugins/nerdcommenter.vim
source ~/configs/plugins/codefmt.vim
source ~/configs/plugins/jedi.vim

let test#strategy = "neovim"
let test#neovim#term_position = "vert"

" Enable the list of buffers
let g:airline#extensions#tabline#enabled = 1

" Show just the filename
let g:airline#extensions#tabline#fnamemod = ':t'

let g:airline_powerline_fonts = 1
let g:airline_theme='base16'

colorscheme solarized
