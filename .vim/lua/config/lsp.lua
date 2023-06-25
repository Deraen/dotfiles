local lsp = require('lsp-zero').preset({})

require("mason").setup()
require("mason-lspconfig").setup {
  ensure_installed = {
    "lua_ls",
    "rust_analyzer",
    "clojure_lsp",
    "tailwindcss",
    "grammarly",
    "tsserver",
  },
}

lsp.on_attach(function(_, bufnr)
  lsp.default_keymaps({
    buffer = bufnr,
    omit = {
      "<F2>", "<F3>", "<F4>",
      "gr",
    },
  })

  -- https://github.com/VonHeikemen/lsp-zero.nvim/blob/v2.x/doc/md/api-reference.md#default_keymapsopts

  local keymap = vim.keymap.set

  local opts = {silent = true, noremap = true}

  -- https://github.com/folke/trouble.nvim
  -- Replace references list with trouble
  keymap("n", "gr", "<cmd>TroubleToggle lsp_references<CR>", opts)

  keymap("n", "<leader>xx", "<cmd>TroubleToggle<CR>", opts)
  keymap("n", "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<CR>", opts)
  keymap("n", "<leader>xd", "<cmd>TroubleToggle document_diagnostics<CR>", opts)
  keymap("n", "<leader>xl", "<cmd>TroubleToggle loclist<CR>", opts)
  keymap("n", "<leader>xq", "<cmd>TroubleToggle quickfix<CR>", opts)

  keymap({"n","v"}, "<leader>ca", vim.lsp.buf.code_action)
  keymap("n", "gR", vim.lsp.buf.rename)
end)

-- Confiure clojure-lsp setup to return parent project folder
-- for multimodule projects, like Reitit.
local lspconfig_util = require 'lspconfig/util'

local lspconfig = require 'lspconfig'

-- To enable debugging
-- vim.lsp.set_log_level("debug")
-- :lua vim.cmd('e'..vim.lsp.get_log_path())

-- Find nrepl port
-- lua clients = vim.lsp.get_active_clients() for k, client_data in ipairs(clients) do id = client_data.id end client = vim.lsp.get_client_by_id(id) result = client.request_sync("clojure/serverInfo/raw", {}, 5000, 15) print('port = ' .. result.result.port) print('log-path = ' .. result.result['log-path'])
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
      --[[
      experimental = {
        classRegex = {
          -- Try enabling emmetCompletions for Hiccup style keys
          -- ":div.([^ ]+)",
          -- Clojure :class "my-2"
          :class \"([^\"]*)\"",
          -- Clojure #tw reader tag
          "#tw \"([^\"]*)\""
        }
      }
      --]]
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

lspconfig.lua_ls.setup(lsp.nvim_lua_ls())

-- lsp-zero will also setup cmp
lsp.setup()

local cmp = require('cmp')

local cmp_action = require('lsp-zero').cmp_action()

cmp.setup({
  sources = {
    {name = 'path'},
    {name = 'nvim_lsp'},
    {name = 'buffer', keyword_length = 3},
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
