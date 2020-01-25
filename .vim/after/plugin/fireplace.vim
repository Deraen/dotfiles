" autocmd FileType clojure nmap <buffer> <F2>  <Plug>FireplaceK
" autocmd FileType clojure nmap <buffer> <F3>  <Plug>FireplaceSource

" Variant of eval where result of expression (outermost form) is pasted onto the document
" following the evaluated form.
" Use case: using VIM like REPL during training presentations

function! s:opfunc(type) abort
  let sel_save = &selection
  let cb_save = &clipboard
  let reg_save = @@
  try
    set selection=inclusive clipboard-=unnamed clipboard-=unnamedplus
    if type(a:type) == type(0)
      let open = '[[{(]'
      let close = '[]})]'
      if getline('.')[col('.')-1] =~# close
        let [line1, col1] = searchpairpos(open, '', close, 'bn', g:fireplace#skip)
        let [line2, col2] = [line('.'), col('.')]
      else
        let [line1, col1] = searchpairpos(open, '', close, 'bcn', g:fireplace#skip)
        let [line2, col2] = searchpairpos(open, '', close, 'n', g:fireplace#skip)
      endif
      while col1 > 1 && getline(line1)[col1-2] =~# '[#''`~@]'
        let col1 -= 1
      endwhile
      call setpos("'[", [0, line1, col1, 0])
      call setpos("']", [0, line2, col2, 0])
      silent exe "normal! `[v`]y"
    elseif a:type =~# '^.$'
      silent exe "normal! `<" . a:type . "`>y"
    elseif a:type ==# 'line'
      silent exe "normal! '[V']y"
    elseif a:type ==# 'block'
      silent exe "normal! `[\<C-V>`]y"
    elseif a:type ==# 'outer'
      call searchpair('(','',')', 'Wbcr', g:fireplace#skip)
      silent exe "normal! vaby"
    else
      silent exe "normal! `[v`]y"
    endif
    redraw
    return repeat("\n", line("'<")-1) . repeat(" ", col("'<")-1) . @@
  finally
    let @@ = reg_save
    let &selection = sel_save
    let &clipboard = cb_save
  endtry
endfunction

function! s:eval_paste(type) abort
  let todo = s:opfunc(a:type)

  let sel_save = &selection
  let cb_save = &clipboard
  let reg_save = @@
  " TODO: Async
  try
    let @@  = fireplace#session_eval(todo)
    if @@ !~#'^\n*$'
      " silent exe "normal %a\<CR><foo>\<CR>"
      silent exe "normal %a\<CR>\<CR>\<Esc>kcc;; => ". @@
    endif
  finally
    let @@ = reg_save
    let &selection = sel_save
    let &clipboard = cb_save
  endtry
endfunction

" nnoremap <silent> <Plug>EvalPasteLast  :exe <SID>paste_last()<CR>
" nnoremap <silent> <Plug>EvalPaste      :<C-U>set opfunc=<SID>eval_paste<CR>g@
" xnoremap <silent> <Plug>EvalPaste      :<C-U>call <SID>eval_paste(visualmode())<CR>
" nnoremap <silent> <Plug>EvalPasteCount :<C-U>call <SID>eval_paste(v:count)<CR>

" nnoremap <silent> <Plug>TestToplevel :<C-U>.RunTests<CR>

function! s:RemoveNs() abort
  " TODO: Async
  let result = fireplace#echo_session_eval("(remove-ns (ns-name *ns*))")
  return result
endfunction

function! s:reset_callback(id, buffer, message) abort
  " TODO: Check out/err/ex prop
  if has_key(a:message, "value")
    echom get(a:message, "value")
  endif

  echom string(a:message)

  if has_key(a:message, "status")
    if index(get(a:message, "status", {}), "done") >= 0
      echom "Success: (reset)"
    else
      echom "Failure: (reset)"
    endif
  endif
endfunction

function! s:ResetReloadedRepl() abort
  " Presume reset from reloaded.repl or integrant.repl or such is loaded in user ns.
  " Using user ns always, should allow fireplace to find connection
  " even when calling this from README.md or such.
  " Only works when inside a folder with .nrepl-port.
  let platform = fireplace#clj()
  echom "Started: (reset)"
  let msg = platform.Message(
        \ {
        \   "op": "eval",
        \   "code": "(reset)",
        \   "ns": platform.UserNs()
        \ },
        \ function("s:reset_callback", [(get(getqflist({'id': 0}), 'id')), []]))
  return msg
endfunction

" nnoremap <silent> <Plug>ResetReloadedRepl :<C-U>call <SID>ResetReloadedRepl()<CR>

" Global binding which can be used from any filetype! E.g. README.md
" nmap cpR <Plug>ResetReloadedRepl

function! s:set_up() abort
  " nmap <buffer> ce  <Plug>EvalPaste
  " nmap <buffer> cep <Plug>EvalPasteCount
  " Remove eval result lines
  " nmap <buffer> ced :%g/^;; =>/d<CR>

  " nmap <buffer> cpt <Plug>TestToplevel

  " <LocalLeader> ö
  " öo = raise form
  " öO = raise element
  " ÖO = raise keyword to symbol (:foo bar) -> foo
  nmap <buffer> ÖO öOBx

  command! -buffer RemoveNs call s:RemoveNs()
endfunction

augroup fireplace_eval_paste
  autocmd!
  autocmd FileType clojure call s:set_up()
augroup END
