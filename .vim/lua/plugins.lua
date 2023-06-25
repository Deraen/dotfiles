-- Alternative package manager https://github.com/folke/lazy.nvim

local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'

  use {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v2.x',
    requires = {
      -- LSP Support
      {'neovim/nvim-lspconfig'},
      {
        'williamboman/mason.nvim',
        run = ':MasonUpdate',
      },
      {'williamboman/mason-lspconfig.nvim'},

      -- Autocompletion
      {'hrsh7th/nvim-cmp'},     -- Required
      {'hrsh7th/cmp-nvim-lsp'}, -- Required
      {'L3MON4D3/LuaSnip'},     -- Required
    }
  }

  --[[
  use({
    "glepnir/lspsaga.nvim",
    opt = true,
    branch = "main",
    event = "LspAttach",
    config = function()
      require("config/lspsaga")
    end,
    requires = {
      {"nvim-tree/nvim-web-devicons"},
      -- Please make sure you install markdown and markdown_inline parser
      --{"nvim-treesitter/nvim-treesitter"}
    }
  })
  ]]--

  use 'folke/trouble.nvim'

  use 'folke/zen-mode.nvim'

  -- Theme
  -- use 'tjdevries/colorbuddy.nvim'
  use 'rebelot/kanagawa.nvim'
  use 'Deraen/seoul256.vim'

  use({
    'nvim-lualine/lualine.nvim',
    config = function()
      require 'config/lualine'
    end
  })

  -- File selector etc.
  -- use {'liuchengxu/vim-clap', run = ':Clap install-binary'}
  -- use 'mhinz/vim-grepper'

  use {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    requires = { {'nvim-lua/plenary.nvim'} }
  }

  use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' }

  use {
    "nvim-telescope/telescope-file-browser.nvim",
    requires = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" }
  }

  -- Autocomplete
  -- use 'hrsh7th/nvim-cmp'
  -- use 'hrsh7th/cmp-buffer'
  -- use 'hrsh7th/cmp-nvim-lsp'
  -- use 'L3MON4D3/LuaSnip'
  -- use 'saadparwaiz1/cmp_luasnip'
  -- Non lsp sources for lsp
  use 'jose-elias-alvarez/null-ls.nvim'

  use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}

  -- Typescript
  use {'windwp/nvim-ts-autotag', ft = 'typescript'}
  -- For formatting - needs prettier
  -- use 'MunifTanjim/prettier.nvim'

  -- Clojure
  use {'clojure-vim/clojure.vim', ft = 'clojure'}
  use {'liquidz/vim-iced', ft = 'clojure'}
  -- use {'liquidz/vim-iced-fern-debugger', ft = 'clojure'}
  use {'guns/vim-sexp', ft = 'clojure'}
  use {'tpope/vim-sexp-mappings-for-regular-people', ft = 'clojure'}
  use {'p00f/nvim-ts-rainbow', ft = 'clojure'}
  -- vimspector supports vscode debug adapters, but calva has
  -- it own debugger system so that doesn't work.
  -- use 'puremourning/vimspector'

  use {'preservim/vim-markdown', ft = 'markdown'}

  -- Colorcodes
  use 'norcalli/nvim-colorizer.lua'

  -- Switch stuff
  -- use 'AndrewRadev/switch.vim'

  -- Text objects
  -- use 'kurkale6ka/vim-pairs'

  -- Show info about unicode char
  use 'tpope/vim-characterize'

  -- Unix shell commands
  use 'tpope/vim-eunuch'

  -- Git wrapper
  -- could replace with lua version: dinhhuy258/git.nvim
  use 'tpope/vim-fugitive'
  -- Github extension
  -- use 'tpope/vim-rhubarb'

  -- Support . to repeat some plugin operations
  use 'tpope/vim-repeat'

  -- Automatically set buffer shiftwidth etc.
  use 'tpope/vim-sleuth'

  -- change surround 'cs' operation
  use 'tpope/vim-surround'

  -- highlight matching html/xml tag
  -- TODO: Is this needed?
  use 'Valloric/MatchTagAlways'

  -- TODO: Is this needed with neovim?
  -- use 'tpope/vim-sensible'

  -- Toggle comments, `gc`
  use 'tpope/vim-commentary'

  -- Some readline stuff for insert mode
  -- TODO: Is this needed?
  use 'tpope/vim-rsi'

  -- Some netrw stuff?
  use 'tpope/vim-vinegar'

  -- Sessions
  use 'tpope/vim-obsession'

  -- Collection of ftplugin
  -- TODO: Is this up to date anymore?
  use 'sheerun/vim-polyglot'

  -- Align stuff
  use 'junegunn/vim-easy-align'

  -- Open and load etc. vimscripts
  use 'tpope/vim-scriptease'

  -- Open color editor
  -- use 'KabbAmine/vCoolor.vim'
  use ({"ziontee113/color-picker.nvim",
    config = function()
      require("color-picker")
    end,
  })

  -- Add some mapping pairs
  use 'tpope/vim-unimpaired'

  -- Some text objects?
  use 'wellle/targets.vim'

  -- Git gutter
  -- use 'airblade/vim-gitgutter'
  use 'jreybert/vimagit'

  -- Replace with register, `gr`
  -- use 'vim-scripts/ReplaceWithRegister'

  -- Wrong file?
  -- use 'EinfachToll/DidYouMean'
  use 'mong8se/actually.nvim'

  -- Create folders if needed
  use 'DataWraith/auto_mkdir'

  -- DB connections
  -- use 'tpope/vim-dadbod'

  -- JSON stuff
  -- use 'tpope/vim-jdaddy'

  -- Close buffers without breaking layout or closing windows
  use 'moll/vim-bbye'

  -- Navigate matches
  use {
    'andymass/vim-matchup',
    setup = function()
      -- may set any options here
      vim.g.matchup_matchparen_offscreen = {}
    end
  }

  use "windwp/nvim-autopairs"

  use {
    "lewis6991/gitsigns.nvim",
    config = function()
      require('gitsigns').setup{
        on_attach = function(bufnr)
          local gs = package.loaded.gitsigns

          local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
          end

          -- Navigation
          map('n', ']c', function()
            if vim.wo.diff then return ']c' end
            vim.schedule(function() gs.next_hunk() end)
            return '<Ignore>'
          end, {expr=true})

          map('n', '[c', function()
            if vim.wo.diff then return '[c' end
            vim.schedule(function() gs.prev_hunk() end)
            return '<Ignore>'
          end, {expr=true})

          -- Actions
          map('n', '<leader>hs', gs.stage_hunk)
          map('n', '<leader>hr', gs.reset_hunk)
          map('v', '<leader>hs', function() gs.stage_hunk {vim.fn.line('.'), vim.fn.line('v')} end)
          map('v', '<leader>hr', function() gs.reset_hunk {vim.fn.line('.'), vim.fn.line('v')} end)
          map('n', '<leader>hS', gs.stage_buffer)
          map('n', '<leader>hu', gs.undo_stage_hunk)
          map('n', '<leader>hR', gs.reset_buffer)
          map('n', '<leader>hp', gs.preview_hunk)
          map('n', '<leader>hb', function() gs.blame_line{full=true} end)
          map('n', '<leader>tb', gs.toggle_current_line_blame)
          map('n', '<leader>hd', gs.diffthis)
          map('n', '<leader>hD', function() gs.diffthis('~') end)
          map('n', '<leader>td', gs.toggle_deleted)

          -- Text object
          map({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
        end
      }
    end
  }

  use 'mrjones2014/smart-splits.nvim'

  -- live preview markdown on browser
  -- use 'iamcco/markdown-preview.nvim'

  -- build keymaps with legends
  -- use 'mrjones2014/legendary.nvim'

  -- show key
  -- use 'folke/which-key.nvim'

  -- Better input and select UI
  use 'stevearc/dressing.nvim'

  use 'sindrets/diffview.nvim'

  if packer_bootstrap then
    require('packer').sync()
  end
end)

