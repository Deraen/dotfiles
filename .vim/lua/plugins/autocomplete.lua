return {
  -- Autocompletion
  {
    'saghen/blink.cmp',
    version = '1.*',
    dependencies = {
      'Kaiser-Yang/blink-cmp-avante',
      -- ... Other dependencies
    },

    -- optional: provides snippets for the snippet source
    -- dependencies = 'rafamadriz/friendly-snippets',

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      -- 'default' for mappings similar to built-in completion
      -- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
      -- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
      -- See the full "keymap" documentation for information on defining your own keymap.
      keymap = {
        preset = 'none',

        ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
        ['<C-e>'] = { 'hide', 'fallback' },
        ['<CR>'] = { 'accept', 'fallback' },
        ["<Tab>"] = {
          function(cmp)
            if cmp.snippet_active() then return cmp.accept()
            else return cmp.select_and_accept() end
          end,
          "snippet_forward",
          "fallback",
        },
        ["<S-Tab>"] = {
          -- function(cmp)
          --   return cmp.select_prev()
          -- end,
          "snippet_backward",
          "fallback",
        },

        ['<Up>'] = { 'select_prev', 'fallback' },
        ['<Down>'] = { 'select_next', 'fallback' },
        ['<C-p>'] = { 'select_prev', 'fallback' },
        ['<C-n>'] = { 'select_next', 'fallback' },

        ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
        ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },
      },

      completion = {
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 500,
          treesitter_highlighting = true,
          window = { border = "none" },
        },
        list = {
          selection = {
            preselect = false,
          }
        }
      },

      -- Experimental signature help support
      signature = {
        enabled = true,
        window = { border = "rounded" },
      },

      appearance = {
        -- Sets the fallback highlight groups to nvim-cmp's highlight groups
        -- Useful for when your theme doesn't support blink.cmp
        -- Will be removed in a future release
        use_nvim_cmp_as_default = true,
        -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
        -- Adjusts spacing to ensure icons are aligned
        nerd_font_variant = 'mono'
      },

      -- Disable cmdline completion for now
      cmdline = {
        enabled = false,
      },
      sources = {
        default = {
          'lsp',
          'path',
          'snippets',
          'avante',
          -- 'buffer'
        },
        per_filetype = {
          codecompanion = { "codecompanion" },
        },
        providers = {
          lsp = {
            score_offset = 0,
          },
          avante = {
            module = 'blink-cmp-avante',
            name = 'Avante',
            opts = {}
          }
        }
      },
    },
    opts_extend = { "sources.default" }
  },
}
