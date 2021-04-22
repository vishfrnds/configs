
"""" KEY BINDINGs """"""

let mapleader=" "	      " defualt \
nnoremap <leader>w :w<CR>
nnoremap <leader>s :source $MYVIMRC<CR>
nnoremap <leader>d :bd<CR>
nnoremap <esc> :noh<return><esc>	" esc to stop highlighting

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


" Easy CAPS
inoremap <c-u> <ESC>viwUi
nnoremap <c-u> viwU<Esc>

" Make 0 go to the first character rather than the beginning
" of the line. When we're programming, we're almost always
" interested in working with text rather than empty space. If
" you want the traditional beginning of line, use ^
nnoremap 0 ^
nnoremap ^ 0


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

