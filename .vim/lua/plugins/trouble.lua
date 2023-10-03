return {
  {
    'folke/trouble.nvim',
    cmd = { 'Trouble', 'TroubleToggle' },
    -- https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/plugins/editor.lua#L407
    keys = {
      { "<leader>xx", "<cmd>TroubleToggle document_diagnostics<cr>", desc = "Document Diagnostics (Trouble)" },
      { "<leader>xX", "<cmd>TroubleToggle workspace_diagnostics<cr>", desc = "Workspace Diagnostics (Trouble)" },
      { "<leader>xL", "<cmd>TroubleToggle loclist<cr>", desc = "Location List (Trouble)" },
      { "<leader>xQ", "<cmd>TroubleToggle quickfix<cr>", desc = "Quickfix List (Trouble)" },
    },
    -- https://github.com/folke/trouble.nvim#setup
    opts = {
      -- for the given modes, automatically jump if there is only a single result
      auto_jump = {},
      cycle_results = false,
      group = true,
      auto_preview = true,

      icons = false,
      fold_open = "-", -- icon used for open folds
      fold_closed = "+", -- icon used for closed folds
      indent_lines = false, -- add an indent guide below the fold icons
      signs = {
        -- icons / text used for a diagnostic
        error = "e",
        warning = "w",
        hint = "h",
        information = "i",
        other = " ",
      },
      -- enabling this will use the signs defined in your lsp client
      use_diagnostic_signs = false
    },
  },
}
