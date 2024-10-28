return {
  -- TODO: lsp-zero is unncessary?
  -- lspsaga?
  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v4.x',
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

      -- And you can configure cmp even more, if you want to.
      local cmp = require('cmp')
      local cmp_action = require('lsp-zero').cmp_action()

      cmp.setup({
        sources = {
          {name = 'path'},
          {name = 'nvim_lsp'},
          -- {name = 'buffer', keyword_length = 3},
          {name = 'luasnip', keyword_length = 2},
        },
        mapping = cmp.mapping.preset.insert({
          ['<CR>'] = cmp.mapping.confirm({select = false}),
          ['<Tab>'] = cmp_action.luasnip_supertab(),
          ['<S-Tab>'] = cmp_action.luasnip_shift_supertab(),
        }),
        snippet = {
          expand = function(args)
            -- You need Neovim v0.10 to use vim.snippet
            vim.snippet.expand(args.body)
          end,
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
      local lspconfig_defaults = require('lspconfig').util.default_config
      lspconfig_defaults.capabilities = vim.tbl_deep_extend(
        'force',
        lspconfig_defaults.capabilities,
        require('cmp_nvim_lsp').default_capabilities()
      )

      vim.api.nvim_create_autocmd('LspAttach', {
        desc = 'LSP actions',
        callback = function(event)
          local keymap = vim.keymap.set

          local opts = {buffer = event.buf, silent = true, noremap = true}

          -- https://github.com/folke/trouble.nvim
          -- Replace references list with trouble
          -- Trouble is keeping data per buffer, so go back to the basic quickfix
          -- keymap("n", "gr", "<cmd>TroubleToggle lsp_references<CR>", opts)

          keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
          keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
          keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
          keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
          keymap('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)

          keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
          -- "gs", -- Default "display signature information" - conflicts with something?
          -- keymap('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)

          -- "<F2>", -- Default "Rename all references to the symbl" binding, replaced with gR
          -- keymap('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
          -- "<F3>", -- Default "Format code in current buffer"
          -- keymap({'n', 'x'}, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
          -- replaced with ca
          -- keymap('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)

          keymap("n", "<leader>xx", "<cmd>TroubleToggle<CR>", opts)
          keymap("n", "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<CR>", opts)
          keymap("n", "<leader>xd", "<cmd>TroubleToggle document_diagnostics<CR>", opts)
          keymap("n", "<leader>xl", "<cmd>TroubleToggle loclist<CR>", opts)
          keymap("n", "<leader>xq", "<cmd>TroubleToggle quickfix<CR>", opts)

          keymap({"n","v"}, "<leader>ca", vim.lsp.buf.code_action, {desc = 'Code actions'})
          keymap("n", "gR", "<cmd>lua vim.lsp.buf.rename()<cr>", {desc = 'LSP Rename'})
          keymap("n", "gF", "<cmd>lua vim.lsp.buf.format({async = true})<cr>", {desc = 'LSP format'})
        end,
      })

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

      require("mason-lspconfig").setup({
        ensure_installed = {
          "lua_ls",
          "rust_analyzer",
          "clojure_lsp",
          "tailwindcss",
          "ts_ls",
          "eslint",
          "bashls"
        },
        handlers = {
          function(server_name)
            require('lspconfig')[server_name].setup({})
          end,

          clojure_lsp = function() end,
          tailwindcss = function() end,

          lua_ls = function()
            lspconfig.lua_ls.setup({
              on_init = function(client)
                require('lsp-zero').nvim_lua_settings(client, {})
              end,
            })
          end,
        }
      })
    end
  }
}
