require 'plugins'
require 'treesitter'

require 'config/lsp'

vim.cmd 'source ~/.vim/config.vim'

vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

require 'colorizer'.setup {
  '*'; -- Highlight all files, but customize some others.
  css = {
    css_fn = true;
  };
  clojure = {
    css_fn = true;
  };
}

local null_ls = require("null-ls")

null_ls.setup({
  sources = {
    -- lspsaga will show gitsigns code actions by default?
    -- null_ls.builtins.code_actions.gitsigns,
    -- null_ls.builtins.formatting.stylua,
    -- null_ls.builtins.diagnostics.eslint,
    -- null_ls.builtins.completion.spell,
  },
})

-- Autopairs config for cmp
-- If you want insert `(` after select function or method item
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
local cmp = require('cmp')
cmp.event:on(
  'confirm_done',
  cmp_autopairs.on_confirm_done()
)

-- Disable autopair ' for clojure
local npairs = require('nvim-autopairs')
local cond = require('nvim-autopairs.conds')

npairs.setup {}
npairs.get_rules("'")[1].not_filetypes = { "clojure" }
npairs.get_rules("'")[1]:with_pair(cond.not_after_text("["))

local trouble = require("trouble")

trouble.setup {
  -- for the given modes, automatically jump if there is only a single result
  -- TODO: Dsiable auto_jump?
  auto_jump = {
    "workspace_diagnostics",
    "lsp_references",
    "lsp_definitions"
  },

  icons = false,
  fold_open = "v", -- icon used for open folds
  fold_closed = ">", -- icon used for closed folds
  indent_lines = false, -- add an indent guide below the fold icons
  signs = {
    -- icons / text used for a diagnostic
    error = "e",
    warning = "w",
    hint = "h",
    information = "i"
  },
  -- enabling this will use the signs defined in your lsp client
  use_diagnostic_signs = false
}
