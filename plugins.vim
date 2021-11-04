call plug#begin(stdpath('data').'/plugged')

Plug 'tpope/vim-surround'

" Shows formatting error warning on status bar
Plug 'vim-syntastic/syntastic'
source ~/configs/plugins/syntastic.vim

Plug 'vim-scripts/indentpython.vim'

Plug 'preservim/nerdcommenter'
source ~/configs/plugins/nerdcommenter.vim

" Telesocop
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
nnoremap <leader>fo <cmd>Telescope oldfiles<cr>

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


" for auto complete
Plug 'github/copilot.vim'
imap <silent><script><expr> <C-k> copilot#Accept("\<C-k>")
let g:copilot_no_tab_map = v:true


Plug 'mhartington/oceanic-next'

Plug 'nvim-lualine/lualine.nvim'

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

Plug 'ThePrimeagen/harpoon'
nnoremap <leader>hm :lua require('harpoon.mark').add_file()<cr>
nnoremap <leader>hu :lua require('harpoon.ui').toggle_quick_menu<cr>

nnoremap <leader>ha :lua require('harpoon.ui').nav_file(1)<CR>
nnoremap <leader>hs :lua require('harpoon.ui').nav_file(2)<CR>
nnoremap <leader>hd :lua require('harpoon.ui').nav_file(3)<CR>
nnoremap <leader>hf :lua require('harpoon.ui').nav_file(4)<CR>

nnoremap <leader>ht :lua require('harpoon.cmd-ui').toggle_quick_menu<cr>



Plug 'neovim/nvim-lspconfig'

Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-path'
Plug 'L3MON4D3/LuaSnip'
Plug 'saadparwaiz1/cmp_luasnip'


Plug 'tpope/vim-vinegar'

call plug#end()

source ~/configs/plugins/codefmt.vim

let test#strategy = "neovim"
let test#neovim#term_position = "vert"


syntax enable
set termguicolors
let g:oceanic_next_terminal_bold = 1
let g:oceanic_next_terminal_italic = 1
colorscheme OceanicNext



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

set completeopt="menu,menuone,noselect"



lua << EOF

require('telescope').setup{
defaults = {
        layout_strategy = 'vertiical',
        path_display = {"truncate"},
        },
}

require'nvim-treesitter.configs'.setup {
ensure_installed = maintained,
highlight = {
enable = true,
additional_vim_regex_highlighting = false,
}
}

--- autocomplete
require('cmp_nvim_lsp').setup{}
local WIDE_HEIGHT = 10
local cmp = require('cmp')
local luasnip = require('luasnip')
cmp.setup{
snippet = {
        expand = function(args)
        require('luasnip').expand(args.body)
end
},
  mapping = {
          ['<c-p>'] = cmp.mapping.select_prev_item(),
          ['<c-n>'] = cmp.mapping.select_next_item(),
          ['<c-Space>'] = cmp.mapping.complete(),
          ['<c-e>'] = cmp.mapping.close(),
          ['<Tab>'] = cmp.mapping(
          function(fallback)
                  if cmp.visible() then
                          cmp.confirm( { behavior = cmp.ConfirmBehavior.Replace, select = true } )
                  elseif luasnip.expand_or_jumpabl() then
                          vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Plug>luasnip-expand-or-jump', true, true, true), '')
                  else
                          fallback()
                  end
          end, {
                  "i",
                  "s",
                  }),
          ['<S-Tab>'] = cmp.mapping(
          function(fallback)
                  if luasnip.jumpable(-1) then
                          vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Plug>luasnip-jump-prev', true, true, true), '')
                  else
                          fallback()
                  end
          end, {
                  "i",
                  "s",
                  }),
          },
  sources = {
          { name = 'nvim_lsp' },
          { name = 'buffer' },
          { name = 'path' },
          { name = 'luasnip' },
          },
  }

local nvim_lsp = require('lspconfig')

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

-- Enable completion triggered by <c-x><c-o>
buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

-- Mappings.
local opts = { noremap=true, silent=true }

-- See `:help vim.lsp.*` for documentation on any of the below functions
buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
buf_set_keymap('n', '<C-h>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
buf_set_keymap('n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
buf_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
buf_set_keymap('n', '<leader>a', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
buf_set_keymap('n', '<leader>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
buf_set_keymap('n', '<leader>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
buf_set_keymap('n', '<leader>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

end

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
vim.lsp.diagnostic.on_publish_diagnostics, {
        virtual_text = false,
        signs = true,
        update = true,
        }
)

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { 'pyright', 'rust_analyzer', 'tsserver' }
for _, lsp in ipairs(servers) do
        nvim_lsp[lsp].setup {
                on_attach = on_attach,
                flags = {
                        debounce_text_changes = 150,
                        }
                }
end


require('lualine').setup{
options = {
        icons_enabled = false,
        component_separators =  { left = '', right = '' },
        section_separators = { left = '', right = '' },
        },

tabline = {
        lualine_a = {'buffers'},
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {}
        },
}
EOF
