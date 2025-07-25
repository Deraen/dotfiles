return {
  -- lspsaga?

  -- Autocompletion
  --[[
  {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      {'L3MON4D3/LuaSnip'},
    },
    config = function()
      -- Here is where you configure the autocompletion settings.
      -- The arguments for .extend() have the same shape as `manage_nvim_cmp`:

      -- And you can configure cmp even more, if you want to.
      local cmp = require('cmp')

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
  ]]--

  {
    'saghen/blink.cmp',
    version = '1.*',
    dependencies = {
      'Kaiser-Yang/blink-cmp-avante',
      -- ... Other dependencies
    },

    -- optional: provides snippets for the snippet source
    -- dependencies = 'rafamadriz/friendly-snippets',

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      -- 'default' for mappings similar to built-in completion
      -- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
      -- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
      -- See the full "keymap" documentation for information on defining your own keymap.
      keymap = {
        preset = 'none',

        ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
        ['<C-e>'] = { 'hide', 'fallback' },
        ['<CR>'] = { 'accept', 'fallback' },
        ["<Tab>"] = {
          function(cmp)
            if cmp.snippet_active() then return cmp.accept()
            else return cmp.select_and_accept() end
          end,
          "snippet_forward",
          "fallback",
        },
        ["<S-Tab>"] = {
          -- function(cmp)
          --   return cmp.select_prev()
          -- end,
          "snippet_backward",
          "fallback",
        },

        ['<Up>'] = { 'select_prev', 'fallback' },
        ['<Down>'] = { 'select_next', 'fallback' },
        ['<C-p>'] = { 'select_prev', 'fallback' },
        ['<C-n>'] = { 'select_next', 'fallback' },

        ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
        ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },
      },

      completion = {
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 500,
          treesitter_highlighting = true,
          window = { border = "none" },
        },
        list = {
          selection = {
            preselect = false,
          }
        }
      },

      -- Experimental signature help support
      signature = {
        enabled = true,
        window = { border = "rounded" },
      },

      appearance = {
        -- Sets the fallback highlight groups to nvim-cmp's highlight groups
        -- Useful for when your theme doesn't support blink.cmp
        -- Will be removed in a future release
        use_nvim_cmp_as_default = true,
        -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
        -- Adjusts spacing to ensure icons are aligned
        nerd_font_variant = 'mono'
      },

      -- Disable cmdline completion for now
      cmdline = {
        enabled = false,
      },
      sources = {
        default = {
          'lsp',
          'path',
          'snippets',
          'avante',
          -- 'buffer'
        },
        per_filetype = {
          codecompanion = { "codecompanion" },
        },
        providers = {
          lsp = {
            score_offset = 0,
          },
          avante = {
            module = 'blink-cmp-avante',
            name = 'Avante',
            opts = {}
          }
        }
      },
    },
    opts_extend = { "sources.default" }
  },

  -- LSP
  {
    'mason-org/mason-lspconfig.nvim',
    cmd = {'LspInfo', 'LspInstall', 'LspStart'},
    event = {'BufReadPre', 'BufNewFile'},
    dependencies = {
      { "mason-org/mason.nvim", opts = {} },
      "neovim/nvim-lspconfig",
    },
    config = function()
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
          -- gri default
          -- keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
          -- keymap('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)

          -- grr default
          -- keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
          -- "gs", -- Default "display signature information" - conflicts with something?
          -- ctrl-s default
          -- keymap('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)

          -- "<F2>", -- Default "Rename all references to the symbl" binding, replaced with gR
          -- keymap('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
          -- "<F3>", -- Default "Format code in current buffer"
          -- keymap({'n', 'x'}, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
          -- replaced with ca
          -- keymap('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)

          -- keymap("n", "<leader>xx", "<cmd>Trouble<CR>", opts)
          keymap("n", "<leader>xw", "<cmd>Trouble diagnostics toggle<CR>", opts)
          keymap("n", "<leader>xd", "<cmd>Trouble diagnostics toggle filter.buf=0<CR>", opts)
          keymap("n", "<leader>xl", "<cmd>Trouble loclist toggle<CR>", opts)
          keymap("n", "<leader>xq", "<cmd>Trouble qflist toggle<CR>", opts)

          -- also gra in default nvim bindings
          keymap({"n","v"}, "<leader>ca", vim.lsp.buf.code_action, {desc = 'Code actions'})
          -- grn default
          -- keymap("n", "gR", "<cmd>lua vim.lsp.buf.rename()<cr>", {desc = 'LSP Rename'})
          keymap("n", "gF", "<cmd>lua vim.lsp.buf.format({async = true})<cr>", {desc = 'LSP format'})
        end,
      })

      -- To enable debugging
      -- vim.lsp.set_log_level("debug")
      -- :lua vim.cmd('e'..vim.lsp.get_log_path())

      -- Find nrepl port
      -- Get id from LspInfo
      -- :lua vim.print(vim.lsp.get_client_by_id(1).request_sync("clojure/serverInfo/raw", {}, 5000, 15))

      --[[
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
      ]]--

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
        automatic_enable = {
          exclude = {
            "clojure_lsp",
            "tailwindcss"
          }
        }
      })

      vim.lsp.config('clojure', {
        -- TODO: Use mason binary?
        cmd = {'clojure-lsp'},
        filetypes = {'clojure', 'edn'},
        -- cmd = {'/home/juho/Source/clojure-lsp/clojure-lsp'},
        -- cmd = {'clojure-lsp', '--trace-level', 'verbose'},
        root_markers = {
          '.clojure-lsp/config.edn', '.lsp/config.edn',
          'project.clj', 'deps.edn', 'build.boot', 'shadow-cljs.edn',
          '.git'
        },
        -- root_dir = function(startpath)
        --   -- Search .lsp/config.edn in the folder tree, then others.
        --   -- So that multi module project top level .lsp/config.edn has the priority.
        --   return lspconfig_util.root_pattern('.clojure-lsp/config.edn', '.lsp/config.edn')(startpath)
        --     or lspconfig_util.root_pattern('project.clj', 'deps.edn', 'build.boot', 'shadow-cljs.edn')(startpath)
        --     or lspconfig_util.root_pattern('.git')(startpath)
        -- end,
      })

      vim.lsp.enable('clojure')

    end
  },
}
