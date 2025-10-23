-- Alternative package manager https://github.com/folke/lazy.nvim
--
--[[
TODO:
https://github.com/jose-elias-alvarez/typescript.nvim
messages, cmdline and popupmenu: https://github.com/folke/noice.nvim
try https://github.com/folke/tokyonight.nvim
https://github.com/nvim-telescope/telescope.nvim/wiki/Gallery#borderless
goolord/alpha-nvim
SmiteshP/nvim-navic
folke/todo-comments.nvim
predefined windows layouts: https://github.com/folke/edgy.nvim
https://github.com/gbprod/yanky.nvim
https://github.com/mfussenegger/nvim-lint if lsp linter isn't available
https://github.com/lewis6991/hover.nvim for non-lsp actions
https://github.com/monaqa/dial.nvim for better increment/decrement
]]--

return {
  -- load colorscheme first and ensure it is not loaded lazily
  {
    'rebelot/kanagawa.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd([[colorscheme kanagawa-dragon]])
    end
  },

  -- Util libs
  { 'nvim-lua/plenary.nvim', lazy = true },

  { 'folke/zen-mode.nvim', cmd = { 'ZenMode' } },

  'junegunn/fzf',
  'ibhagwan/fzf-lua',

  -- https://github.com/RRethy/vim-illuminate
  {
    'RRethy/vim-illuminate',
    enabled = false,
    event = { "BufReadPost", "BufNewFile" },
    keys = {
      { ']]' },
      { '[[' },
    },
    opts = {
      delay = 200,
      large_file_cutoff = 2000,
      large_file_overrides = {
        providers = { 'lsp' },
      }
    },
    config = function (_, opts)
      require("illuminate").configure(opts)

      local function map(key, dir, buffer)
        vim.keymap.set("n", key, function()
          require("illuminate")["goto_" .. dir .. "_reference"](false)
        end, { desc = dir:sub(1, 1):upper() .. dir:sub(2) .. " Reference", buffer = buffer })
      end

      map("]]", "next")
      map("[[", "prev")

      -- also set it after loading ftplugins, since a lot overwrite [[ and ]]
      vim.api.nvim_create_autocmd("FileType", {
        callback = function()
          local buffer = vim.api.nvim_get_current_buf()
          map("]]", "next", buffer)
          map("[[", "prev", buffer)
        end,
      })
    end
  },

  {
    'kevinhwang91/nvim-bqf',
    ft = 'qf',
    opts = {
      auto_resize_height = true,
      preview = {
        -- Toggle preview with P
        auto_preview = false,
        border = 'single',
        winblend = 12,
      },
      filter = {
        fzf = {
          extra_opts = {'--bind', 'ctrl-o:toggle-all', '--delimiter', '│'}
        }
      }
    },
  },

  -- Navigate code
  -- ggandor/flit.nvim & ggandor/leap.nvim
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {
      modes = {
        search = {
          enabled = false,
        }
      }
    },
    -- stylua: ignore
    keys = {
      { "s", mode = { "n", "o", "x" }, function() require("flash").jump() end, desc = "Flash" },
      { "S", mode = { "n", "o", "x" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
      { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
      { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
    },
  },

  -- vimspector supports vscode debug adapters, but calva has
  -- it own debugger system so that doesn't work.
  -- use 'puremourning/vimspector'

  {
    'preservim/vim-markdown',
    ft = 'markdown'
  },

  -- Switch stuff
  -- use 'AndrewRadev/switch.vim'
  -- let g:switch_mapping = "<C-s>"

  -- Text objects
  -- use 'kurkale6ka/vim-pairs'

  -- Show info about unicode char
  'tpope/vim-characterize',

  -- Unix shell commands
  'tpope/vim-eunuch',

  -- Support . to repeat some plugin operations
  -- VeryLazy doesn't work, won't be registered correctly.
  'tpope/vim-repeat',

  -- Automatically set buffer shiftwidth etc.
  'tpope/vim-sleuth',

  -- change surround 'cs' operation
  'tpope/vim-surround',

  -- Toggle comments, `gc`
  'tpope/vim-commentary',
  -- 'numToStr/Comment.nvim',

  -- Some readline stuff for insert mode
  -- TODO: Is this needed?
  {
    'tpope/vim-rsi',
    init = function()
      -- Disable meta maps because <M-d> bindings breaks ä
      vim.g.rsi_no_meta = 1
    end
  },

  -- Some netrw stuff?
  'tpope/vim-vinegar',

  -- Sessions
  -- 'tpope/vim-obsession',
  {
    "folke/persistence.nvim",
    event = "BufReadPre",
    opts = {},
    keys = {
      { "<leader>qs", function() require("persistence").load() end, desc = "Restore Session" },
      { "<leader>qS", function() require("persistence").select() end,desc = "Select Session" },
      { "<leader>ql", function() require("persistence").load({ last = true }) end, desc = "Restore Last Session" },
      { "<leader>qd", function() require("persistence").stop() end, desc = "Don't Save Current Session" },
    },
  },

  -- Align stuff
  -- TODO: https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-align.md
  -- 'junegunn/vim-easy-align',
  -- vmap <Enter> <Plug>(EasyAlign)

  -- Open and load etc. vimscripts
  -- 'tpope/vim-scriptease',

  -- Add some mapping pairs
  'tpope/vim-unimpaired',

  -- Some text objects?
  'wellle/targets.vim',

  -- Wrong file?
  -- use 'EinfachToll/DidYouMean'
  'mong8se/actually.nvim',

  -- Create folders if needed
  'DataWraith/auto_mkdir',

  -- DB connections
  -- use 'tpope/vim-dadbod'

  -- JSON stuff
  -- use 'tpope/vim-jdaddy'

  -- Close buffers without breaking layout or closing windows
  -- 'moll/vim-bbye',
  -- {
  --   'echasnovski/mini.bufremove',
  --   keys = {
  --     {'<M-w>', function() require('mini.bufremove').delete(0, false) end}
  --   },
  --   opts = {},
  -- },
  -- Now: Snacks

  -- Navigate matches
  -- {
  --   'andymass/vim-matchup',
  --   config = function()
  --     -- may set any options here
  --     vim.g.matchup_matchparen_offscreen = {}
  --   end
  -- },

  -- TODO: https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-pairs.md
  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    opts = {
      enable_check_bracket_line = false,
      check_ts = true,
      ts_config = {
        lua = {'string', 'comment'},
      },
    },
    config = function(_, opts)
      local npairs = require('nvim-autopairs')

      npairs.setup(opts)

      local cond = require('nvim-autopairs.conds')
      -- local basic = require('nvim-autopairs.rules.basic')

      npairs.get_rules("'")[1].not_filetypes = { "clojure", "scheme", "lisp" }
      npairs.get_rules("'")[1]:with_pair(cond.not_after_text("["))

      npairs.get_rules("`")[1].not_filetypes = { "clojure" }
      npairs.get_rules("`")[1]:with_pair(cond.not_after_text("["))
    end
  },
  -- Is enabled on comments?

  -- live preview markdown on browser
  -- use 'iamcco/markdown-preview.nvim'

  -- build keymaps with legends
  -- use 'mrjones2014/legendary.nvim'

  -- Better input and select UI
  -- {
  --   "stevearc/dressing.nvim",
  --   event = 'VeryLazy',
  -- },
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
      bigfile = { enabled = true },
      dashboard = { enabled = true },
      input = { enabled = true },
      picker = { enabled = true },
      quickfile = { enabled = true },
      notifier = { enabled = true },
    },
    keys = {
      {'<M-w>', function () Snacks.bufdelete() end, { desc = "Delete buffer" }}
    }
  },
}
