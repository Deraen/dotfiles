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
]]--

return {
  { "nvim-lua/plenary.nvim", lazy = true },
  { 'folke/zen-mode.nvim', cmd = { 'ZenMode' } },

  -- Theme
  -- 'tjdevries/colorbuddy.nvim',
  {
    'rebelot/kanagawa.nvim',
    priority = 1000,
    config = function()
      vim.cmd([[colorscheme kanagawa-dragon]])
    end
  },
  {
    'Deraen/seoul256.vim',
    enabled = false,
    init = function ()
      vim.g.seoul256_srgb = 1
      vim.cmd([[colorscheme seoul256]])
    end
  },

  -- File selector etc.
  -- use {'liuchengxu/vim-clap', run = ':Clap install-binary'}
  -- TODO: vimgrepper? -> https://github.com/RRethy/vim-illuminate
  -- TODO: nvim-pack/nvim-spectre search and replace in files
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
    'nvim-pack/nvim-spectre',
    cmd = 'Spectre',
    opts = {
      open_cmd = 'noswapfile vnew',
    },
    keys = {
      { "<leader>sr", function() require("spectre").open() end, desc = "Replace in files (Spectre)" },
    }
  },
  {
    'mhinz/vim-grepper',
    cmd = { 'Grepper', 'GrepperGit', 'GrepperAg', 'GrepperRg', 'GrepperGrep' },
    keys = {
      { '<leader>gg', ':Grepper -tool git<cr>', noremap = true, desc = 'Git grep' },
      { '<leader>ga', ':Grepper -tool ag<cr>', noremap = true, desc = 'Ag grep' },
      { '<leader>gs', '<plug>(GrepperOperator)', desc =  'Grep operator' },
      { '<leader>gs', '<plug>(GrepperOperator)', mode = 'x', desc = 'Grep operator' },
    },
  },

  -- Vs. trouble?
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

  -- Autocomplete
  -- use 'hrsh7th/cmp-buffer'
  -- use 'saadparwaiz1/cmp_luasnip'

  -- Typescript
  {'windwp/nvim-ts-autotag', ft = 'typescript'},
  -- For formatting - needs prettier
  -- use 'MunifTanjim/prettier.nvim'

  -- vimspector supports vscode debug adapters, but calva has
  -- it own debugger system so that doesn't work.
  -- use 'puremourning/vimspector'

  {
    'preservim/vim-markdown', 
    ft = 'markdown'
  },

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

  -- highlight matching html/xml tag
  -- TODO: Is this needed?
  -- 'Valloric/MatchTagAlways',

  -- TODO: Is this needed with neovim?
  -- use 'tpope/vim-sensible'

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
  -- TODO: https://github.com/folke/persistence.nvim
  -- TODO: https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-sessions.md
  'tpope/vim-obsession',

  -- Collection of ftplugin
  -- TODO: Is this up to date anymore?
  -- 'sheerun/vim-polyglot',

  -- Align stuff
  -- TODO: https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-align.md
  -- 'junegunn/vim-easy-align',
  -- vmap <Enter> <Plug>(EasyAlign)

  -- Open and load etc. vimscripts
  -- 'tpope/vim-scriptease',

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

  -- Add some mapping pairs
  'tpope/vim-unimpaired',

  -- Some text objects?
  'wellle/targets.vim',

  -- Replace with register, `gr`
  -- use 'vim-scripts/ReplaceWithRegister'

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
  -- TODO: https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-bufremove.md
  -- 'moll/vim-bbye',
  {
    'echasnovski/mini.bufremove',
    keys = {
      {'<M-w>', function() require('mini.bufremove').delete(0, false) end}
    },
    opts = {},
  },

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
      local basic = require('nvim-autopairs.rules.basic')

      npairs.get_rules("'")[1].not_filetypes = { "clojure", "scheme", "lisp" }
      npairs.get_rules("'")[1]:with_pair(cond.not_after_text("["))

      npairs.get_rules("`")[1].not_filetypes = { "clojure" }
      npairs.get_rules("`")[1]:with_pair(cond.not_after_text("["))
    end
  },
  -- Is enabled on comments?

  {
    'mrjones2014/smart-splits.nvim',
    opts = {
      at_edge = 'stop',
    },
    keys = function(_, opts)
      return {
        {'<C-h>', function (...) require('smart-splits').resize_left(...) end, desc = 'Resize left'},
        {'<C-j>', function (...) require('smart-splits').resize_down(...) end, desc = 'Resize down'},
        {'<C-k>', function (...) require('smart-splits').resize_up(...) end, desc = 'Resize left'},
        {'<C-l>', function (...) require('smart-splits').resize_right(...) end, desc = 'Resize right'},

        {'<A-h>', function (...) require('smart-splits').move_cursor_left(...) end, desc = 'Move to left'},
        {'<A-j>', function (...) require('smart-splits').move_cursor_down(...) end, desc = 'Move to down'},
        {'<A-k>', function (...) require('smart-splits').move_cursor_up(...) end, desc = 'Move to up'},
        {'<A-l>', function (...) require('smart-splits').move_cursor_right(...) end, desc = 'Move to right'},
      }
    end,
  },

  -- live preview markdown on browser
  -- use 'iamcco/markdown-preview.nvim'

  -- build keymaps with legends
  -- use 'mrjones2014/legendary.nvim'

  -- Better input and select UI
  {
    "stevearc/dressing.nvim",
    lazy = true,
    init = function()
      ---@diagnostic disable-next-line: duplicate-set-field
      vim.ui.select = function(...)
        require("lazy").load({ plugins = { "dressing.nvim" } })
        return vim.ui.select(...)
      end
      ---@diagnostic disable-next-line: duplicate-set-field
      vim.ui.input = function(...)
        require("lazy").load({ plugins = { "dressing.nvim" } })
        return vim.ui.input(...)
      end
    end,
  },

  -- which-key helps you remember key bindings by showing a popup
  -- with the active keybindings of the command you started typing.
  {
    "folke/which-key.nvim",
    enabled = false,
    event = "VeryLazy",
    opts = {
      plugins = { spelling = true },
      defaults = {
        mode = { "n", "v" },
        -- ["g"] = { name = "+goto" },
        -- ["gz"] = { name = "+surround" },
        -- ["]"] = { name = "+next" },
        -- ["["] = { name = "+prev" },
        -- ["<leader><tab>"] = { name = "+tabs" },
        -- ["<leader>b"] = { name = "+buffer" },
        -- ["<leader>c"] = { name = "+code" },
        -- ["<leader>f"] = { name = "+file/find" },
        ["<leader>h"] = { name = "+git" },
        -- ["<leader>gh"] = { name = "+hunks" },
        -- ["<leader>q"] = { name = "+quit/session" },
        -- ["<leader>s"] = { name = "+search" },
        -- ["<leader>u"] = { name = "+ui" },
        -- ["<leader>w"] = { name = "+windows" },
        -- ["<leader>x"] = { name = "+diagnostics/quickfix" },
        ["<leader>x"] = { name = "+diagnostics/quickfix" },
      },
      show_help = false,
    },
    config = function(_, opts)
      vim.o.timeout = true
      vim.o.timeoutlen = 500
      local wk = require("which-key")
      wk.setup(opts)
      wk.register(opts.defaults)
    end,
  },
}
