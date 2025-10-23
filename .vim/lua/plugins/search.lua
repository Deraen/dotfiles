return {
  {
    -- Fork:
    --- 'andrew-grechkin/vim-grepper',
    'mhinz/vim-grepper',
    cmd = { 'Grepper', 'GrepperGit', 'GrepperAg', 'GrepperRg', 'GrepperGrep' },
    keys = {
      { '<leader>gg', ':Grepper -tool git<cr>', noremap = true, desc = 'Git grep' },
      { '<leader>ga', ':Grepper -tool ag<cr>', noremap = true, desc = 'Ag grep' },
      { '<leader>gs', '<plug>(GrepperOperator)', desc =  'Grep operator' },
      { '<leader>gs', '<plug>(GrepperOperator)', mode = 'x', desc = 'Grep operator' },
    },
  },
  {
    'nvim-pack/nvim-spectre',
    cmd = 'Spectre',
    opts = {
      open_cmd = 'noswapfile vnew',
    },
    keys = {
      { "<leader>sr", function() require("spectre").open() end, desc = "Replace in files (Spectre)" },
    }
  },
}
