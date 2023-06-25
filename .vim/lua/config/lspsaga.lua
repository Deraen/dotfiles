require("lspsaga").setup({
  lightbulb = {
    enable = false
  },
  symbol_in_winbar = {
    enable = false
  },
  code_action = {
    extend_gitsigns = true,
    keys = {
      quit = { "q", "<C-c>", "<ESC>" }
    }
  }
})

