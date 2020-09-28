" set the runtime path to include Vundle and initialize
"
" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/home/v/.local/share/nvim/plugged')


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
tmap <C-o> <C-\><C-n>       " use C-o to visual mode in term


