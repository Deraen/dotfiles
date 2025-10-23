return {
  -- Colorcodes
  -- TODO: https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-hipatterns.md
  {
    'NvChad/nvim-colorizer.lua',
    opts = {
      filetypes = {
        '*'; -- Highlight all files, but customize some others.
        css = {
          css_fn = true;
        };
        clojure = {
          css_fn = true;
        };
      }
    }
  },

  -- Open color editor
  -- use 'KabbAmine/vCoolor.vim'
  {
    "ziontee113/color-picker.nvim",
    keys = {
      { '<leader>cc', '<cmd>PickColor<cr>', 'n', noremap = true, silent = true, desc = 'Color picker' }
      -- vim.keymap.set("i", "<C-c>", "<cmd>PickColorInsert<cr>", opts)

      -- vim.keymap.set("n", "your_keymap", "<cmd>ConvertHEXandRGB<cr>", opts)
      -- vim.keymap.set("n", "your_keymap", "<cmd>ConvertHEXandHSL<cr>", opts)
    },
    opts = {
      -- r changes color type
      -- o changes output color type
      ["icons"] = { "", "" },
      ["border"] = "single",
    },
  },
}
