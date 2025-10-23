return {
  -- 'tjdevries/colorbuddy.nvim',
  {
    'Deraen/seoul256.vim',
    enabled = true,
    init = function ()
      vim.g.seoul256_srgb = 1
      -- vim.cmd([[colorscheme seoul256]])
    end
  },
}
