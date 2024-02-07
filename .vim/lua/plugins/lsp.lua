return {
  -- TODO: lsp-zero is unncessary?
  -- lspsaga?
  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v3.x',
    lazy = true,
    config = false,
    init = function()
      vim.g.lsp_zero_ui_float_border = 'none'
    end
  },
  {
    'williamboman/mason.nvim',
    lazy = false,
    config = true,
  },

  -- Autocompletion
  {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      {'L3MON4D3/LuaSnip'},
    },
    config = function()
      -- Here is where you configure the autocompletion settings.
      -- The arguments for .extend() have the same shape as `manage_nvim_cmp`:
      -- https://github.com/VonHeikemen/lsp-zero.nvim/blob/v2.x/doc/md/api-reference.md#manage_nvim_cmp

      local lsp_zero = require('lsp-zero')

      lsp_zero.extend_cmp()

      -- And you can configure cmp even more, if you want to.
      local cmp = require('cmp')
      local cmp_action = lsp_zero.cmp_action()

      cmp.setup({
        sources = {
          {name = 'path'},
          {name = 'nvim_lsp'},
          -- {name = 'buffer', keyword_length = 3},
          {name = 'luasnip', keyword_length = 2},
        },
        mapping = {
          ['<CR>'] = cmp.mapping.confirm({select = false}),
          ['<Tab>'] = cmp_action.luasnip_supertab(),
          ['<S-Tab>'] = cmp_action.luasnip_shift_supertab(),
        },
        enabled = function()
          -- disable completion in comments
          local context = require 'cmp.config.context'
          -- keep command mode completion enabled when cursor is in a comment
          if vim.api.nvim_get_mode().mode == 'c' then
            return true
          else
            return not context.in_treesitter_capture("comment")
              and not context.in_syntax_group("Comment")
          end
        end
      })
    end
  },

  -- LSP
  {
    'neovim/nvim-lspconfig',
    cmd = {'LspInfo', 'LspInstall', 'LspStart'},
    event = {'BufReadPre', 'BufNewFile'},
    dependencies = {
      {'hrsh7th/cmp-nvim-lsp'},
      {'williamboman/mason-lspconfig.nvim'},
    },
    config = function()
      local lsp_zero = require('lsp-zero')
      lsp_zero.extend_lspconfig()

      lsp_zero.on_attach(function(client, bufnr)
        -- lsp-zero won't overwrite mappings
        -- https://github.com/VonHeikemen/lsp-zero.nvim/tree/v3.x#keybindings
        lsp_zero.default_keymaps({
          buffer = bufnr,
          omit = {
            "<F2>", -- Default "Rename all references to the symbl" binding, used with code-actions
            "<F3>", -- Default "Format code in current buffer"
            "<F4>", -- Default "Code action" replaced with <leader>ca
            -- "gr", -- replaced by Trouble references bind below
            "gs", -- Default "display signature information" - conflicts with something?
          },
        })

        -- https://github.com/VonHeikemen/lsp-zero.nvim/blob/v2.x/doc/md/api-reference.md#default_keymapsopts

        local keymap = vim.keymap.set

        local opts = {silent = true, noremap = true}

        -- https://github.com/folke/trouble.nvim
        -- Replace references list with trouble
        -- Trouble is keeping data per buffer, so go back to the basic quickfix
        -- keymap("n", "gr", "<cmd>TroubleToggle lsp_references<CR>", opts)

        keymap("n", "<leader>xx", "<cmd>TroubleToggle<CR>", opts)
        keymap("n", "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<CR>", opts)
        keymap("n", "<leader>xd", "<cmd>TroubleToggle document_diagnostics<CR>", opts)
        keymap("n", "<leader>xl", "<cmd>TroubleToggle loclist<CR>", opts)
        keymap("n", "<leader>xq", "<cmd>TroubleToggle quickfix<CR>", opts)

        keymap({"n","v"}, "<leader>ca", vim.lsp.buf.code_action, {desc = 'Code actions'})
        keymap("n", "gR", vim.lsp.buf.rename, {desc = 'LSP Rename'})
      end)

      -- Configure clojure-lsp setup to return parent project folder
      -- for multimodule projects, like Reitit.
      local lspconfig_util = require 'lspconfig/util'

      local lspconfig = require 'lspconfig'

      -- To enable debugging
      -- vim.lsp.set_log_level("debug")
      -- :lua vim.cmd('e'..vim.lsp.get_log_path())

      -- Find nrepl port
      -- Get id from LspInfo
      -- :lua vim.print(vim.lsp.get_client_by_id(1).request_sync("clojure/serverInfo/raw", {}, 5000, 15))
      lspconfig.clojure_lsp.setup {
        -- cmd = {'/home/juho/Source/clojure-lsp/clojure-lsp'},
        -- cmd = {'clojure-lsp', '--trace-level', 'verbose'},
        flags = {
          debounce_text_change = 150,
        },
        root_dir = function(startpath)
          -- Search .lsp/config.edn in the folder tree, then others.
          -- So that multi module project top level .lsp/config.edn has the priority.
          return lspconfig_util.root_pattern('.lsp/config.edn')(startpath)
            or lspconfig_util.root_pattern('project.clj', 'deps.edn', 'build.boot', 'shadow-cljs.edn')(startpath)
            or lspconfig_util.root_pattern('.git')(startpath)
        end,
      }

      lspconfig.tailwindcss.setup {
        -- Only enable if config found in the project, not for every clojure project
        root_dir = lspconfig_util.root_pattern('tailwind.config.js'),
        flags = {
          debounce_text_change = 150,
        },
        filetypes = { "clojure", "javascript", "javascriptreact", "typescript", "typescriptreact", "html", "css" },
        settings = {
          tailwindCSS = {
            validate = true,
            classAttributes = { "class", "className", "classList", "ngClass" },
            emmetCompletions = true,
            lint = {
              cssConflict = "warning",
              invalidApply = "error",
              invalidConfigPath = "error",
              invalidScreen = "error",
              invalidTailwindDirective = "error",
              invalidVariant = "error",
              recommendedVariantOrder = "warning"
            },
            includeLanguages = {
              clojure = "html"
            },
          }
        }
      }

      require'lspconfig'.tsserver.setup{}

      lspconfig.grammarly.setup {
        autostart = false,
        filetypes = { "markdown" },
        settings = {
          grammarly = {
          }
        }
      }

      -- (Optional) Configure lua language server for neovim
      lspconfig.lua_ls.setup(lsp_zero.nvim_lua_ls())

      require("mason-lspconfig").setup({
        ensure_installed = {
          "lua_ls",
          "rust_analyzer",
          "clojure_lsp",
          "tailwindcss",
          "grammarly",
          "tsserver",
        },
        handlers = {
          lsp_zero.default_setup,
        }
      })

    end
  }
}
