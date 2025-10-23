return {
  {
    'mason-org/mason-lspconfig.nvim',
    cmd = {'LspInfo', 'LspInstall', 'LspStart'},
    event = {'BufReadPre', 'BufNewFile'},
    dependencies = {
      {
        'mason-org/mason.nvim',
        cmd = {'Mason', 'MasonInstall', 'MasonLog', 'MasonUpdate', 'MasonUninstall', 'MasonUninstallAll'},
        opts = {},
      },
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
          keymap("n", "gR", ":IncRename ", {desc = 'LSP Rename'})
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
          -- would use .lsp as the root folder
          -- '.clojure-lsp/config.edn', '.lsp/config.edn',
          'project.clj', 'deps.edn', 'build.boot', 'shadow-cljs.edn',
          '.git'
        },
        -- see:
        root_dir = function(_bufnr, on_dir)
          local lsp_file_config = vim.fs.find({'.clojure-lsp/config.edn', '.lsp/config.edn'}, {
            upward = true,
            type = "file",
            path = vim.fn.getcwd(),
          })[1]

          local root_path = (lsp_file_config and vim.fs.normalize(vim.fs.joinpath(vim.fs.dirname(lsp_file_config), '../fixme')))
          or vim.fs.find({'project.clj', 'deps.edn', 'build.boot', 'shadow-cljs.edn'}, {
            upward = true,
            type = "file",
            path = vim.fn.getcwd(),
          })[1] or vim.fs.find('.git', {
            upward = true,
            type = "file",
            path = vim.fn.getcwd(),
          })[1]

          if root_path then
            on_dir(vim.fn.fnamemodify(root_path, ":h"))
          end
        end,
      })

      vim.lsp.enable('clojure')

    end
  },

  {
    "smjonas/inc-rename.nvim",
    opts = {
      input_buffer_type = "snacks",
    }
  },
}
