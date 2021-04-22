call  plug#begin(stdpath('data').'/plugged')

" Shows git mod in gutter
Plug 'mhinz/vim-signify'

" TELESCOPE
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
nnoremap <leader>fc <cmd>Telescope find_files find_command=rg,--files,/home/v/configs<cr>
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep prompt_prefix=🔍<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
nnoremap <silent> gd <cmd>lua require('telescope.builtin').lsp_definitions()<CR>

" TELESCOPE


Plug 'tpope/vim-vinegar'
" use -
let g:netrw_list_hide = '\(^\|\s\s\)\zs\.\S\+'

" <leader>/
Plug 'preservim/nerdcommenter'
source ~/configs/plugins/nerdcommenter.vim

" status bar
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" Enable the list of buffers
let g:airline#extensions#tabline#enabled = 1
" Show just the filename
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline_powerline_fonts = 1

Plug 'christoomey/vim-tmux-navigator'
" Write all buffers before navigating from Vim to tmux pane
let g:tmux_navigator_save_on_switch = 2

Plug 'altercation/vim-colors-solarized'

Plug 'neovim/nvim-lspconfig'


" for auto complete
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'Shougo/deoplete-lsp'

call plug#end()

colorscheme solarized

lua << EOF

local nvim_lsp = require('lspconfig')
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'ga', '<Cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  -- buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<leader>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<leader>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)

  print ('lsp started')
  print(client.resolved_capabilities.document_formatting)
  -- Set some keybinds conditional on server capabilities
  if client.resolved_capabilities.document_formatting then
    buf_set_keymap("n", "<leader>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
  elseif client.resolved_capabilities.document_range_formatting then
    buf_set_keymap("n", "<leader>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
  end


  
  -- Set autocommands conditional on server_capabilities
--  if client.resolved_capabilities.document_highlight then
--    require('lspconfig').util.nvim_multiline_command [[
--      :hi LspReferenceRead cterm=bold ctermbg=red guibg=LightYellow
--      :hi LspReferenceText cterm=bold ctermbg=red guibg=LightYellow
--      :hi LspReferenceWrite cterm=bold ctermbg=red guibg=LightYellow
--      augroup lsp_document_highlight
--        autocmd!
--        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
--        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
--      augroup END
--    ]]
--  end
end

-- Use a loop to conveniently both setup defined servers 
-- and map buffer local keybindings when the language server attaches
local servers = { "pyls", "cssls" }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup { on_attach = on_attach }
end


local function get_node_modules(root_dir)
  -- util.find_node_modules_ancestor()
  local root_node = root_dir .. "/node_modules"
  local stats = vim.loop.fs_stat(root_node)
  if stats == nil then
    return nil
  else
    return root_node
  end
end
local function organize_imports()
  local params = {
    command = "_typescript.organizeImports",
    arguments = {vim.api.nvim_buf_get_name(0)},
    title = ""
  }
  vim.lsp.buf.execute_command(params)
end

local project_library_path = get_node_modules(vim.fn.getcwd())
local cmd = {"ngserver", "--stdio", "--tsProbeLocations", project_library_path , "--ngProbeLocations", project_library_path}

nvim_lsp.angularls.setup{
  cmd = cmd,
  on_attach = on_attach,
  on_new_config = function(new_config,new_root_dir)
    new_config.cmd = cmd
  end,
}
nvim_lsp.groovyls.setup{
  on_attach = on_attach,
  cmd = { "java", "-jar", "~/github/groovy-language-server/build/libs/groovy-language-server-all.jar" },
}

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
        signs = true,
        underline = false,
        update_in_insert = false,
        virtual_text = false,
    }
)
EOF

"auto completion
let g:deoplete#enable_at_startup = 1
" call deoplete#custom#source('_', 'matchers', ['matcher_full_fuzzy'])
" call deoplete#custom#option({'camel_case': v:true,})

set completeopt="menuone,longest"

" enter to select
" inoremap <expr><CR> pumvisible() ? "\<C-N>" : "\<CR>"

" For example, the following will map <Tab> to either actually insert a <Tab> if
" the current line is currently only whitespace, or start/continue a CTRL-N
" completion operation: >
	" function! CleverTab()
	"    if strpart( getline('.'), 0, col('.')-1 ) =~ '^\s*$'
	"       return "\<Tab>"
	"    else
	"       return "\<C-N>"
	"    endif
	" endfunction
    "
	" inoremap <Tab> <C-R>=CleverTab()<CR>

" After plug end

" let g:markdown_fenced_languages = ['html', 'vim', 'ruby', 'python', 'bash=sh', 'rust', 'haskell', 'c', 'cpp']

" lsp
autocmd BufWritePre *.py lua vim.lsp.buf.formatting_sync(nil, 1000)
nnoremap <silent> g[ <cmd>lua vim.lsp.diagnostic.goto_prev()<CR>
nnoremap <silent> g] <cmd>lua vim.lsp.diagnostic.goto_next()<CR>
nnoremap <silent> gh <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> <leader>rn <cmd>lua vim.lsp.buf.rename()<CR>

