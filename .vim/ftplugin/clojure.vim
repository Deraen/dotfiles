" Clojure test
autocmd FileType clojure setlocal lispwords+=describe,it
" Core.match
autocmd FileType clojure setlocal lispwords+=match
" Compojure-api
autocmd FileType clojure setlocal lispwords+=context,swaggered,middleware,context*
" Midje
autocmd FileType clojure setlocal lispwords+=fact,facts,provided,fact-group
" Core.logic
autocmd FileType clojure setlocal lispwords+=run*
" Om
autocmd FileType clojure setlocal lispwords+=will-mount,render,render-state,init-state,did-mount,should-update,will-receive-props,will-update,did-update,display-name,will-unmount
" Om next
autocmd FileType clojure setlocal lispwords+=ident
" Cljs
autocmd FileType clojure setlocal lispwords+=this-as,async
" Plumbing
autocmd FileType clojure setlocal lispwords+=for-map,fnk,letk
" Core.async
autocmd FileType clojure setlocal lispwords+=go-loop
" Chesire
autocmd FileType clojure setlocal lispwords+=add-encoder
" Boot
autocmd FileType clojure setlocal lispwords+=with-call-in,with-eval-in,with-pre-wrap,with-post-wrap
" Cats
autocmd FileType clojure setlocal lispwords+=with-context,alet,mlet
" Clojure.spec
autocmd FileType clojure setlocal lispwords+=fdef

" Vim-iced

let g:iced_enable_auto_document = 1

" silent! nmap <buffer> <Leader>' <Plug>(iced_connect)
" silent! nmap <buffer> <Leader>" <Plug>(iced_jack_in)

"" Evaluating (<Leader>e)
silent! nmap <buffer> ceq <Plug>(iced_interrupt)
silent! nmap <buffer> ceQ <Plug>(iced_interrupt_all)
silent! nmap <buffer> cp <Plug>(iced_eval)
silent! nmap <buffer> cpp <Plug>(iced_eval)<Plug>(sexp_inner_element)``
" silent! nmap <buffer> <Leader>ee <Plug>(iced_eval)<Plug>(sexp_outer_list)``
" silent! nmap <buffer> <Leader>et <Plug>(iced_eval_outer_top_list)
silent! vmap <buffer> cp <Plug>(iced_eval_visual)
silent! nmap <buffer> cpe <Plug>(iced_eval_ns)
silent! nmap <buffer> cpl <Plug>(iced_print_last)

silent! nmap <buffer> cpr <Plug>(iced_require)
silent! nmap <buffer> cpR <Plug>(iced_require_all)

silent! nmap <buffer> cdd <Plug>(iced_undef)
silent! nmap <buffer> cdD <Plug>(iced_undef_all_in_ns)

silent! nmap <buffer> cmm <Plug>(iced_macroexpand_outer_list)
silent! nmap <buffer> c1mm <Plug>(iced_macroexpand_1_outer_list)

"" Testing
silent! nmap <buffer> ctt <Plug>(iced_test_ns)
silent! nmap <buffer> cty <Plug>(iced_test_under_cursor)
silent! nmap <buffer> ctl <Plug>(iced_test_rerun_last)
" silent! nmap <buffer> <Leader>ts <Plug>(iced_test_spec_check)
silent! nmap <buffer> cta <Plug>(iced_test_all)
silent! nmap <buffer> ctr <Plug>(iced_test_redo)

"" Stdout buffer (<Leader>s)
silent! nmap <buffer> cbb <Plug>(iced_stdout_buffer_open)
silent! nmap <buffer> cbc <Plug>(iced_stdout_buffer_clear)
silent! nmap <buffer> cbt <Plug>(iced_test_buffer_open)
" silent! nmap <buffer> <Leader>sq <Plug>(iced_stdout_buffer_close)

"" Refactoring (<Leader>r)
" silent! nmap <buffer> <Leader>rcn <Plug>(iced_clean_ns)
" silent! nmap <buffer> <Leader>rca <Plug>(iced_clean_all)
" silent! nmap <buffer> <Leader>ram <Plug>(iced_add_missing)
" silent! nmap <buffer> <Leader>ran <Plug>(iced_add_ns)
" silent! nmap <buffer> <Leader>rtf <Plug>(iced_thread_first)
" silent! nmap <buffer> <Leader>rtl <Plug>(iced_thread_last)
" silent! nmap <buffer> <Leader>ref <Plug>(iced_extract_function)
" silent! nmap <buffer> <Leader>raa <Plug>(iced_add_arity)
" silent! nmap <buffer> <Leader>rml <Plug>(iced_move_to_let)

"" Help/Document (<Leader>h)
" silent! nmap <buffer> K <Plug>(iced_document_popup_open)
silent! nmap <buffer> <F2> <Plug>(iced_document_popup_open)
" silent! nmap <buffer> <Leader>hb <Plug>(iced_document_open)
" silent! nmap <buffer> <Leader>hu <Plug>(iced_use_case_open)
" silent! nmap <buffer> <Leader>hn <Plug>(iced_next_use_case)
" silent! nmap <buffer> <Leader>hN <Plug>(iced_prev_use_case)
" silent! nmap <buffer> <Leader>hq <Plug>(iced_document_close)
silent! nmap <buffer> <F3> <Plug>(iced_source_show)
silent! nmap <buffer> chs <Plug>(iced_source_show)
" silent! nmap <buffer> <Leader>hs <Plug>(iced_source_popup_show)
silent! nmap <buffer> chd <Plug>(iced_clojuredocs_open)
silent! nmap <buffer> chh <Plug>(iced_command_palette)

"" Browsing (<Leader>b)
silent! nmap <buffer> cbn <Plug>(iced_browse_related_namespace)
silent! nmap <buffer> cbs <Plug>(iced_browse_spec)
silent! nmap <buffer> cbt <Plug>(iced_browse_test_under_cursor)
silent! nmap <buffer> cbr <Plug>(iced_browse_references)
silent! nmap <buffer> cbd <Plug>(iced_browse_dependencies)
silent! nmap <buffer> cbvr <Plug>(iced_browse_var_references)
silent! nmap <buffer> cbvd <Plug>(iced_browse_var_dependencies)

"" Jumping cursor (<Leader>j)
silent! nmap <buffer> <C-]> <Plug>(iced_def_jump)
" silent! nmap <buffer> <Leader>jn <Plug>(iced_jump_to_next_sign)
" silent! nmap <buffer> <Leader>jN <Plug>(iced_jump_to_prev_sign)
silent! nmap <buffer> cjl <Plug>(iced_jump_to_let)

"" Debugging (<Leader>d)
" silent! nmap <buffer> <Leader>dbt <Plug>(iced_browse_tapped)
" silent! nmap <buffer> <Leader>dlt <Plug>(iced_clear_tapped)

"" Misc
" silent! nmap <buffer> == <Plug>(iced_format)
" silent! nmap <buffer> =G <Plug>(iced_format_all)
" silent! nmap <buffer> <Leader>* <Plug>(iced_grep)
" silent! nmap <buffer> <Leader>/ :<C-u>IcedGrep<Space>

" nnoremap <buffer> <Leader>go :<C-u>IcedEval (user/go)<CR>
nnoremap <buffer> cpR :<C-u>IcedEval (do (in-ns 'user) (reset))<CR>

" let g:iced_formatter = 'zprint'

function! s:auto_connect() abort
  if expand('%:t') ==# 'project.clj' || expand('%:e') ==# 'edn'
    return
  endif
  call IcedConnect
endfunction

aug ClojureSettings
  au!
  " au VimEnter * call s:auto_connect()
aug END

aug VimIcedAutoOpenQuickfix
  au!
  au QuickFixCmdPost vim-iced cwindow
aug END
