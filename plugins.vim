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
" Plug 'davidhalter/jedi-vim'

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

Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'

" for auto complete
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

Plug 'lighttiger2505/deoplete-vim-lsp'

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


" whether to enable diagnostics for vim-lsp (we may want to use ALE for other
" plugins for that.
let g:lsp_diagnostics_enabled = 1

" show diagnostic signs
let g:lsp_signs_enabled = 1
let g:lsp_signs_error = {'text': '✗'}
let g:lsp_signs_warning = {'text': '!'}
let g:lsp_highlights_enabled = 0

" Do not use virtual text, they are far too obtrusive.
let g:lsp_virtual_text_enabled = 0
" Do not echo a diagnostic message at cursor position
let g:lsp_diagnostics_echo_cursor = 0
" show diagnostic in floating window
let g:lsp_diagnostics_float_cursor = 1
let g:lsp_diagnostics_float_delay = 2000
" whether to enable highlight a symbol and its references
let g:lsp_highlight_references_enabled = 1
let g:lsp_preview_max_width = 80

function! s:on_lsp_buffer_enabled() abort
    " setlocal omnifunc=lsp#complete
    " setlocal signcolumn=yes
    if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
    nmap <buffer> gd <plug>(lsp-definition)
    nmap <buffer> gr <plug>(lsp-references)
    nmap <buffer> gi <plug>(lsp-implementation)
    nmap <buffer> gt <plug>(lsp-type-definition)
    nmap <buffer> <leader>rn <plug>(lsp-rename)
    nmap <buffer> [g <Plug>(lsp-previous-diagnostic)
    nmap <buffer> ]g <Plug>(lsp-next-diagnostic)
    nmap <buffer> K <plug>(lsp-hover)
    " refer to doc to add more commands
endfunction


augroup lsp_install
    au!
    " call s:on_lsp_buffer_enabled only for languages that has the server registered.
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END

"auto completion
let g:deoplete#enable_at_startup = 1

set completeopt="menuone,longest"

" enter to select
inoremap <expr><CR> pumvisible() ? "\<C-N>" : "\<CR>"

" For example, the following will map <Tab> to either actually insert a <Tab> if
" the current line is currently only whitespace, or start/continue a CTRL-N
" completion operation: >
	function! CleverTab()
	   if strpart( getline('.'), 0, col('.')-1 ) =~ '^\s*$'
	      return "\<Tab>"
	   else
	      return "\<C-N>"
	   endif
	endfunction

	inoremap <Tab> <C-R>=CleverTab()<CR>



