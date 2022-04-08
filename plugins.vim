call plug#begin(stdpath('data').'/plugged')

Plug 'zbirenbaum/copilot.lua'

Plug 'folke/which-key.nvim'

Plug 'mhinz/vim-startify'


Plug 'tpope/vim-surround'

" Shows formatting error warning on status bar
Plug 'vim-syntastic/syntastic'
source ~/configs/plugins/syntastic.vim

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


Plug 'lewis6991/gitsigns.nvim'
" Plug 'tpope/vim-fugitive'

"" https://github.com/google/vim-codefmt 
" Add maktaba and codefmt to the runtimepath.
" (The latter must be installed before it can be used.)
Plug 'google/vim-maktaba'
Plug 'google/vim-codefmt'
" Also add Glaive, which is used to configure codefmt's maktaba flags. See
" `:help :Glaive` for usage.
Plug 'google/vim-glaive'


" for auto complete
" Plug 'github/copilot.vim'
" imap <silent><script><expr> <C-k> copilot#Accept("\<C-k>")
" let g:copilot_no_tab_map = v:true

Plug 'nvim-lualine/lualine.nvim'

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

Plug 'ThePrimeagen/harpoon'
nnoremap <leader>mm :lua require('harpoon.mark').add_file()<cr>
nnoremap <leader>mu :lua require('harpoon.ui').toggle_quick_menu()<cr>

nnoremap <leader>ma :lua require('harpoon.ui').nav_file(1)<CR>
nnoremap <leader>ms :lua require('harpoon.ui').nav_file(2)<CR>
nnoremap <leader>md :lua require('harpoon.ui').nav_file(3)<CR>
nnoremap <leader>mf :lua require('harpoon.ui').nav_file(4)<CR>

nnoremap <leader>mt :lua require('harpoon.cmd-ui').toggle_quick_menu()<cr>
nnoremap <leader>mj :lua require("harpoon.term").gotoTerminal(1)  <cr>
nnoremap <leader>mk :lua require("harpoon.term").gotoTerminal(2)  <cr>
nnoremap <leader>ml :lua require("harpoon.term").gotoTerminal(3)  <cr>
nnoremap <leader>mr :lua require("harpoon.term").sendCommand(1, 1)  <cr>
nnoremap <leader>me :lua require("harpoon.term").sendCommand(2, 2)  <cr>



Plug 'neovim/nvim-lspconfig'

Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp-signature-help'
Plug 'zbirenbaum/copilot-cmp'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-path'
Plug 'L3MON4D3/LuaSnip'
Plug 'saadparwaiz1/cmp_luasnip'

Plug 'tpope/vim-vinegar'


Plug 'nvim-neorg/neorg'

Plug 'catppuccin/nvim', {'as': 'catppuccin'}

" Plug 'mhartington/oceanic-next'
" Plug 'altercation/vim-colors-solarized'



call plug#end()

lua << EOF

  require("which-key").setup {
      window = {
        border = "single", -- none, single, double, shadow
        position = "top", -- bottom, top
        margin = { 30, 100, 10, 2 }, -- extra window margin [top, right, bottom, left]
        padding = { 0, 0, 0, 0 }, -- extra window padding [top, right, bottom, left]
        winblend = 0
      },
      layout = {
        height = { min = 10, max = 100 }, -- min and max height of the columns
        width = { min = 10, max = 90 }, -- min and max width of the columns
        spacing = 3, -- spacing between columns
        align = "right", -- align columns left, center or right
      },
  }
EOF

" the glaive#Install() should go after the "call vundle#end()"
call glaive#Install()
" Optional: Enable codefmt's default mappings on the <Leader>= prefix.
Glaive codefmt plugin[mappings]

augroup autoformat_settings
  autocmd FileType bzl AutoFormatBuffer buildifier
  autocmd FileType c,cpp,proto,javascript,arduino AutoFormatBuffer clang-format
  autocmd FileType dart AutoFormatBuffer dartfmt
  autocmd FileType go AutoFormatBuffer gofmt
  autocmd FileType gn AutoFormatBuffer gn
  autocmd FileType html,css,sass,scss,less,json AutoFormatBuffer js-beautify
  autocmd FileType java AutoFormatBuffer google-java-format
  autocmd FileType python AutoFormatBuffer yapf
  " Alternative: autocmd FileType python AutoFormatBuffer autopep8
  autocmd FileType rust AutoFormatBuffer rustfmt
  autocmd FileType vue AutoFormatBuffer prettier
augroup END



lua << EOF


local catppuccin = require("catppuccin").setup {
  integrations = {
    	which_key = true,
  },
}

require("harpoon").setup{
  global_settings = {
    enter_on_sendcmd = true,
  },
}


    require('neorg').setup {
        -- Tell Neorg what modules to load
        load = {
            ["core.defaults"] = {}, -- Load all the default modules
            ["core.norg.concealer"] = {}, -- Allows for use of icons
            ["core.norg.dirman"] = { -- Manage your directories with Neorg
                config = {
                    workspaces = {
                        my_workspace = "~/neorg"
                    }
                }
            },
          ["core.norg.completion"] = {
                config = {
                  engine = "nvim-cmp" -- We current support nvim-compe and nvim-cmp only
                }
          },
        },
    }

  local parser_configs = require('nvim-treesitter.parsers').get_parser_configs()

  parser_configs.norg = {
    install_info = {
        url = "https://github.com/nvim-neorg/tree-sitter-norg",
        files = { "src/parser.c", "src/scanner.cc" },
        branch = "main"
    },
  }

EOF

syntax enable
set termguicolors
" let g:oceanic_next_terminal_bold = 1
" let g:oceanic_next_terminal_italic = 1
" colorscheme OceanicNext
colorscheme catppuccin




lua << EOF

require('telescope').setup{
defaults = {
    layout_strategy = 'vertical',
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

require("copilot").setup{
  plugin_manager_path = vim.fn.stdpath("data") .. "/plugged", -- Installation Path of packer, change to the plugin manager installation path of your choice
}


vim.opt.completeopt = "menuone,noselect"

require('cmp_nvim_lsp').setup{}
local WIDE_HEIGHT = 10
local cmp = require('cmp')
local luasnip = require('luasnip')
require'cmp'.setup.cmdline(':', {
  sources = {
    { name = 'cmdline' }
  }
})
cmp.setup{
  snippet = {
      expand = function(args)
      require('luasnip').expand(args.body)
  end
  },
  style = {
    winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder",
   },
  window = {
    completion = {
      border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
      scrollbar = "║",
      autocomplete = {
        require("cmp.types").cmp.TriggerEvent.InsertEnter,
        require("cmp.types").cmp.TriggerEvent.TextChanged,
      },
    },
    documentation = {
      border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
      winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder",
      scrollbar = "║",
    },
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
          elseif luasnip.expand_or_jumpable() then
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
  experimental = {
    native_menu = false,
    ghost_text = true,
  },
  sources = {
      { name = 'copilot'},
      { name = 'nvim_lsp' },
      { name = 'nvim_lsp_signature_help' },
      { name = 'luasnip' },
      { name = "neorg" },
      { name = 'buffer' },
      { name = 'path' },
  },
  sorting = {
    comparators = {
      cmp.config.compare.recently_used,
      cmp.config.compare.offset,
      cmp.config.compare.score,
      cmp.config.compare.sort_text,
      cmp.config.compare.length,
      cmp.config.compare.order,
    },
  },
  preselect = cmp.PreselectMode.Item,
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
  buf_set_keymap('i', '<C-h>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<leader>a', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', '<leader>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[e', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']e', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<leader>e', '<cmd>lua vim.diagnostic.set_loclist()<CR>', opts)

  if client.resolved_capabilities.document_formatting then
      buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
      vim.cmd([[
      augroup lsp_format
          autocmd! * <buffer>
          autocmd BufWritePost <buffer> lua vim.lsp.buf.formatting_asyn()
      augroup END
      ]])
  end

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
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

for _, lsp in ipairs(servers) do
    nvim_lsp[lsp].setup {
        capabilities = capabilities,
        on_attach = on_attach,
        flags = {
            debounce_text_changes = 150,
            }
        }
end


require('gitsigns').setup{
  on_attach = function(bufnr)
    local gs = package.loaded.gitsigns

    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    -- Navigation
    map('n', ']c', "&diff ? ']c' : '<cmd>Gitsigns next_hunk<CR>'", {expr=true})
    map('n', '[c', "&diff ? '[c' : '<cmd>Gitsigns prev_hunk<CR>'", {expr=true})

    -- Actions
    map({'n', 'v'}, '<leader>hs', ':Gitsigns stage_hunk<CR>')
    map({'n', 'v'}, '<leader>hr', ':Gitsigns reset_hunk<CR>')
    map('n', '<leader>hS', gs.stage_buffer)
    map('n', '<leader>hu', gs.undo_stage_hunk)
    map('n', '<leader>hR', gs.reset_buffer)
    map('n', '<leader>hp', gs.preview_hunk)
    map('n', '<leader>hb', function() gs.blame_line{full=true} end)
    map('n', '<leader>tb', gs.toggle_current_line_blame)
    map('n', '<leader>hd', gs.diffthis)
    map('n', '<leader>hD', function() gs.diffthis('~') end)
    map('n', '<leader>td', gs.toggle_deleted)

    -- Text object
    map({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
  end

}

local function diff_source()
  local gitsigns = vim.b.gitsigns_status_dict
  if gitsigns then
    return {
      added = gitsigns.added,
      modified = gitsigns.changed,
      removed = gitsigns.removed,
    }
  end
end

require('lualine').setup{
options = {
    icons_enabled = false,
    component_separators =  { left = '', right = '' },
    section_separators = { left = '', right = '' },
    globalstatus = true,
    theme = "catppuccin"
  },
sections = {
      lualine_a = {'mode'},
      lualine_b = {{'b:gitsigns_head'},
                   {'diff', source = diff_source},
                   {'diagnostics', sources={'nvim_lsp'}}
                  },
      lualine_c = {{
        'filename',
        file_status = true,  -- displays file status (readonly status, modified status)
        path = 1,            -- 0 = just filename, 1 = relative path, 2 = absolute path
        shorting_target = 40 -- Shortens path to leave 40 space in the window
                             -- for other components. Terrible name any suggestions?
      }},
      lualine_x = {'filetype'},
      lualine_y = {},
      lualine_z = {'progress', 'location'}
},

tabline = {
    lualine_a = {'buffers'},
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {'tabs'}
    },
}
EOF
