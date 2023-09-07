return {
  {
    'nvim-lualine/lualine.nvim',
    event = 'VeryLazy',
    opts = {
      options = {
        icons_enabled = false,
        theme = 'auto',
        -- component_separators = { left = '', right = ''},
        -- section_separators = { left = '', right = ''},
        component_separators = { left = '', right = ''},
        section_separators = { left = '', right = ''},
        disabled_filetypes = {
          statusline = { "Trouble" },
          winbar = {},
        },
        ignore_focus = {},
        always_divide_middle = true,
        globalstatus = false,
        refresh = {
          statusline = 1000,
          tabline = 1000,
          winbar = 1000,
        }
      },
      sections = {
        lualine_a = {{'mode', fmt = function(s) return s:sub(1,1) end}},
        -- branch, diff
        lualine_b = {'diagnostics'},
        lualine_c = {{'filename', path = 1}},
        -- fileformat, encoding, filetype
        lualine_x = {},
        -- progress
        lualine_y = {},
        lualine_z = {'location'}
      },
      inactive_sections = {
        lualine_a = {function() return '-' end},
        lualine_b = {'diagnostics'},
        lualine_c = {{'filename', path = 1}},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {'location'}
      },
      tabline = {},
      winbar = {},
      inactive_winbar = {},
      extensions = {}
    }
  },
}
