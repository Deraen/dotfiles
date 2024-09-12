return {
  -- Clojure
  {
    'clojure-vim/clojure.vim', 
    ft = 'clojure',
    init = function ()
      -- Lispwords settings on ~/.vim/after/ftplugin/clojure.vim
      vim.g.clojure_align_multiline_strings = 0
      vim.g.clojure_maxlines = 200

      vim.cmd([[autocmd BufNewFile,BufReadPost *.boot setfiletype clojure]])
      vim.cmd([[autocmd BufNewFile,BufReadPost *.bb setfiletype clojure]])
    end
  },
  {
    'liquidz/vim-iced',
    ft = 'clojure',
    init = function ()
      vim.g.iced_formatter = 'zprint'
      vim.g.iced_enable_auto_indent = false
      vim.g.iced_enable_auto_document = ''
      -- let g:iced#nrepl#skip_evaluation_when_buffer_size_is_exceeded = v:true
      vim.g['iced#nrepl#enable_sideloader'] = true
      -- let g:iced_enable_clj_kondo_analysis = true
      -- let g:iced_enable_clj_kondo_local_analysis = v:true
      vim.g['iced#buffer#stdout.max_line'] = 10000
      vim.g['iced#selector#search_order'] = {'fzf'}
      vim.g['iced#source_root'] = vim.fn.stdpath('data') .. '/lazy/vim-iced'
    end
  },
  -- use {'liquidz/vim-iced-fern-debugger', ft = 'clojure'}
  -- {
  --   'liquidz/vim-iced-telescope-selector',
  --   ft = 'clojure'
  -- },
  {
    'guns/vim-sexp',
    ft = 'clojure',
    init = function ()
      vim.g.sexp_enable_insert_mode_mappings = 0
      -- These confict with my window bindings, tpopes plugin already has these bound
      -- to rational keys
      vim.g.sexp_mappings = {
        sexp_swap_list_backward = '',
        sexp_swap_list_forward = '',
        sexp_swap_element_backward = '',
        sexp_swap_element_forward = '',
        sexp_move_to_prev_element_head = '',
        sexp_move_to_next_element_head = '',
        sexp_move_to_prev_element_tail = '',
        sexp_move_to_next_element_tail = '',
        sexp_raise_list =                '<LocalLeader>o',
        sexp_raise_element =             '<LocalLeader>O',
      }
    end
  },
  {'tpope/vim-sexp-mappings-for-regular-people', ft = 'clojure'},
  -- Replace, no longer maintained
  -- use {'p00f/nvim-ts-rainbow', ft = 'clojure'}
}
