return {
  -- use {'liuchengxu/vim-clap', run = ':Clap install-binary'}
  -- Replaced with Snacks.nvim for now
  {
    'nvim-telescope/telescope.nvim',
    enabled = false,
    cmd = 'Telescope',
    version = false, -- telescope did only one release, so use HEAD for now
    keys = {
      {'<c-p>', '<cmd>Telescope git_files<cr>'},
      {'<leader>ff', '<cmd>Telescope find_files<cr>'},
      {'<c-b>', '<cmd>Telescope buffers<cr>'},
      -- NOTE: Telescope doesn't support colored output to show the matched string
      {'<leader>fg', '<cmd>Telescope live_grep<cr>'},
      {'<leader>fh', '<cmd>Telescope help_tags<cr>'},
    },
    opts = {
      defaults = {
        mappings = {
          -- n mode is disabled
          n = {
            ["<M-p>"] = function(...) return require('telescope.actions.layout').toggle_preview(...) end,
            ["<c-t>"] = function(...) return require('trouble.providers.telescope').open_with_trouble(...) end,
          },
          i = {
            -- disable n mode
            ["<esc>"] = function(...) return require('telescope.actions').close(...) end,
            ["<M-p>"] = function(...) return require('telescope.actions.layout').toggle_preview(...) end,
            ["<C-u>"] = false,
            ["<c-t>"] = function(...) return require('trouble.providers.telescope').open_with_trouble(...) end,
            -- In additon to c-n / c-p
            ["<c-j>"] = function(...) return require('telescope.actions').move_selection_next(...) end,
            ["<c-k>"] = function(...) return require('telescope.actions').move_selection_previous(...) end,
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
          sort_lastused = true,
          sort_mru = true,
          mappings = {
            i = {
              ["<c-d>"] = function(...) return require('telescope.actions').delete_buffer(...) end,
              -- alt-w to match regular binding
              ["<m-w>"] = function(...) return require('telescope.actions').delete_buffer(...) end,
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
    },
  },
  {
    "nvim-telescope/telescope-file-browser.nvim",
    enabled = false,
    keys = {
      { '<leader>fb', '<cmd>Telescope file_browser path=%:p:h select_buffer=true<cr>', noremap = true, desc = 'Telescope file browser' },
    },
    config = function()
      require('telescope').load_extension('file_browser')
    end
  },
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    enabled = false,
    build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build',
    event = 'VeryLazy',
    config = function()
      require('telescope').load_extension('fzf')
    end
  },
  {
    'nvim-telescope/telescope-smart-history.nvim',
    enabled = false,
    dependencies = {
      "kkharji/sqlite.lua",
    },
    event = 'VeryLazy',
    config = function()
      require('telescope').load_extension('smart_history')
    end
  },
  {
    "folke/snacks.nvim",
    keys = {
      {'<c-p>', function() Snacks.picker.git_files() end},
      {'<leader>ff', function() Snacks.picker.files() end},
      {'<c-b>', function() Snacks.picker.buffers() end},
      -- NOTE: Telescope doesn't support colored output to show the matched string
      {'<leader>fg', function() Snacks.picker.grep() end},
      {'<leader>fh', function() Snacks.picker.help() end},
    },
    ---@type snacks.Config
    opts = {
      picker = {
        matcher = {
          -- sort_empty = true,
          frecency = true, -- frecency bonus
          history_bonus = true, -- give more weight to chronological order
        },
        win = {
          input = {
            keys = {
              ["<Esc>"] = { "close", mode = { "n", "i" } },
            }
          }
        },
        sources = {
          buffers = {
            matcher = {
              sort_empty = true,
            },
            win = {
              input = {
                keys = {
                  -- In addition to <C-x> close buffers with <M-w>
                  ["<M-w>"] = { "bufdelete", mode = { "n", "i" } },
                }
              }
            }
          }
        }
      },
      -- ui_select = true, -- replace `vim.ui.select` with the snacks picker
      -- icons = {
      --   files = {
      --     enabled = false,
      --   }
      -- }
    }
  }
}
