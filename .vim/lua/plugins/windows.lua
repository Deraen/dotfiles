return {
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
}
