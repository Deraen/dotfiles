require 'plugins'

require 'config/treesitter'
require 'config/lsp'
require 'config/quickfix'

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

-- local null_ls = require("null-ls")

-- null_ls.setup({
--   sources = {
--     null_ls.builtins.code_actions.gitsigns,
--     -- null_ls.builtins.formatting.stylua,
--     -- null_ls.builtins.diagnostics.eslint,
--     null_ls.builtins.completion.spell,
--   },
-- })

-- Autopairs config for cmp
-- If you want insert `(` after select function or method item
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
local cmp = require('cmp')
cmp.event:on(
  'confirm_done',
  cmp_autopairs.on_confirm_done()
)

local telescope = require 'telescope'
local keymap = vim.keymap.set
local tbuiltin = require('telescope.builtin')
keymap('n', '<c-p>', tbuiltin.git_files, {})
keymap('n', '<leader>ff', tbuiltin.find_files, {})
keymap('n', '<c-b>', tbuiltin.buffers, {})
keymap('n', '<leader>fb', tbuiltin.buffers, {})

-- NOTE: Telescope doesn't support colored output to show the matched string
keymap('n', '<leader>fg', tbuiltin.live_grep, {})
keymap('n', '<leader>fh', tbuiltin.help_tags, {})

-- keymap({'n', 'v'}, '<leader>gg', '<Plug>(GrepperOperator)', {})

local troublet = require("trouble.providers.telescope")
local actions = require("telescope.actions")
local action_layout = require("telescope.actions.layout")
telescope.setup{
  defaults = {
    mappings = {
      -- n mode is disabled
      n = {
        ["<M-p>"] = action_layout.toggle_preview,
        ["<c-t>"] = troublet.open_with_trouble,
      },
      i = {
        -- disable n mode
        ["<esc>"] = actions.close,
        ["<M-p>"] = action_layout.toggle_preview,
        ["<C-u>"] = false,
        ["<c-t>"] = troublet.open_with_trouble,
        -- In additon to c-n / c-p
        ["<c-j>"] = actions.move_selection_next,
        ["<c-k>"] = actions.move_selection_previous,
      },
    },
    padding = false,
    sorting_strategy = "ascending",
    cycle_results = false,
    layout_config = {
      horizontal = {
        height = 0.6,
        prompt_position = "top",
      }
    },
    history = {
      path = '~/.local/share/nvim/telescope_history.sqlite3',
      limit = 100,
    }
  },
  pickers = {
    buffers = {
      sorting_strategy = "ascending",
      mappings = {
        i = {
          ["<c-d>"] = actions.delete_buffer,
          -- alt-w to match regular binding
          ["<m-w>"] = actions.delete_buffer,
        }
      }
    },
    git_files = {
      sorting_startegy = "ascending",
    }
  },
  extensions = {
    file_browser = {
      -- disables netrw and use telescope-file-browser in its place
      -- hijack_netrw = true,
      dir_icon = "D",
      mappings = {
        ["i"] = {
        },
        ["n"] = {
        },
      },
    },
    fzf = {
      fuzzy = true,                    -- false will only do exact matching
      override_generic_sorter = true,  -- override the generic sorter
      override_file_sorter = true,     -- override the file sorter
      case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
      -- the default case_mode is "smart_case"
    },
  },
}

telescope.load_extension "file_browser"
telescope.load_extension('fzf')
telescope.load_extension("frecency")
telescope.load_extension('smart_history')

-- keymap('n', '<leader>fb', telescope.extensions.file_browser.file_browser, {})
keymap("n", "<leader>fb", ":Telescope file_browser path=%:p:h select_buffer=true<cr>", { noremap = true })

-- Disable autopair ' for clojure
local npairs = require('nvim-autopairs')
local cond = require('nvim-autopairs.conds')

npairs.setup {}
npairs.get_rules("'")[1].not_filetypes = { "clojure" }
npairs.get_rules("'")[1]:with_pair(cond.not_after_text("["))

local trouble = require("trouble")

trouble.setup {
  -- for the given modes, automatically jump if there is only a single result
  -- TODO: Disable auto_jump?
  auto_jump = {
    -- "workspace_diagnostics",
    -- "lsp_references",
    -- "lsp_definitions",
  },

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
}

require('smart-splits').setup({
  at_edge = 'stop'
})

-- recommended mappings
-- resizing splits
-- these keymaps will also accept a range,
-- for example `10<A-h>` will `resize_left` by `(10 * config.default_amount)`
vim.keymap.set('n', '<C-h>', require('smart-splits').resize_left)
vim.keymap.set('n', '<C-j>', require('smart-splits').resize_down)
vim.keymap.set('n', '<C-k>', require('smart-splits').resize_up)
vim.keymap.set('n', '<C-l>', require('smart-splits').resize_right)
-- moving between splits
vim.keymap.set('n', '<A-h>', require('smart-splits').move_cursor_left)
vim.keymap.set('n', '<A-j>', require('smart-splits').move_cursor_down)
vim.keymap.set('n', '<A-k>', require('smart-splits').move_cursor_up)
vim.keymap.set('n', '<A-l>', require('smart-splits').move_cursor_right)
-- swapping buffers between windows
-- <c-w> HJKL is enough
-- vim.keymap.set('n', '<leader><leader>h', require('smart-splits').swap_buf_left)
-- vim.keymap.set('n', '<leader><leader>j', require('smart-splits').swap_buf_down)
-- vim.keymap.set('n', '<leader><leader>k', require('smart-splits').swap_buf_up)
-- vim.keymap.set('n', '<leader><leader>l', require('smart-splits').swap_buf_right)

local opts = { noremap = true, silent = true }

vim.keymap.set("n", "<leader>cc", "<cmd>PickColor<cr>", opts)
-- vim.keymap.set("i", "<C-c>", "<cmd>PickColorInsert<cr>", opts)

-- vim.keymap.set("n", "your_keymap", "<cmd>ConvertHEXandRGB<cr>", opts)
-- vim.keymap.set("n", "your_keymap", "<cmd>ConvertHEXandHSL<cr>", opts)

-- r changes color type
-- o changes output color type
require("color-picker").setup({
  ["icons"] = { "", "" },
  ["border"] = "single",
})

-- Toggle hlsearch yoh
-- highlight word under cursor or visual with *

require("diffview").setup{
  use_icons = false,
  icons = {
    folder_closed = "+",
    folder_open = "-",
  },
  signs = {
    fold_closed = "+",
    fold_open = "-",
    done = "x",
  }
}

require("bqf").setup{
  preview = {
    auto_preview = false,
  }
}
