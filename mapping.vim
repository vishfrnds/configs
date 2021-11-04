
"""" KEY BINDINGs """"""

nnoremap <SPACE> <Nop>
let mapleader=" "	      " defualt \

nnoremap <esc> :noh<return><esc>	" esc to stop highlighting

nnoremap Y y$  " like capital commands

nnoremap n nzzzv
nnoremap N Nzzzv

" undo break points
inoremap , ,<c-g>u
inoremap . .<c-g>u
inoremap ! !<c-g>u
inoremap ? ?<c-g>u
inoremap - -<c-g>u

" stop using arrows
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>

" split winodow navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>


" Use alt + hjkl to resize split windows
nnoremap <M-j>    :resize -2<CR>
nnoremap <M-k>    :resize +2<CR>
nnoremap <M-h>    :vertical resize -2<CR>
nnoremap <M-l>    :vertical resize +2<CR>

" TAB in general mode will move to text buffer
nnoremap <TAB> :bnext<CR>
" SHIFT-TAB will go back
nnoremap <S-TAB> :bprevious<CR>

imap ii <Esc>
tnoremap ii <C-\><C-n> " Exit insert mode in terminal


" Better tabbing, use <, > to shift and select again
vnoremap < <gv
vnoremap > >gv

nmap <silent> <leader>t :TestNearest<CR>
nmap <silent> <leader>T :TestFile<CR>
nmap <silent> <leader>a :TestSuite<CR>
nmap <silent> <leader>l :TestLast<CR>
nmap <silent> <leader>g :TestVisit<CR>

" make 0 go to the first character of the line
nnoremap 0 ^
nnoremap ^ 0

nnoremap <leader>q :bd<CR>
nnoremap <leader>w :w<CR>
nnoremap <leader>d :SignifyDiff<CR>

