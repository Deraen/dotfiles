autocmd FileType clojure nunmap <buffer> K
autocmd FileType clojure nmap <buffer> <F2>  <Plug>FireplaceK
autocmd FileType clojure nmap <buffer> <F3>  <Plug>FireplaceSource

function! s:eval_paste(type) abort
  let reg_save = @@
  let sel_save = &selection
  let cb_save = &clipboard
  try
    set selection=inclusive clipboard-=unnamed clipboard-=unnamedplus

    " Find start of the block
    call searchpair('(','',')', 'Wbcr', g:fireplace#skip)
    " Copy contents
    silent exe "normal! vaby"
    let expr = repeat("\n", line("'<")-1) . repeat(" ", col("'<")-1) . @@
    " Eval contents
    let @@ = "\n;; => " . fireplace#session_eval(matchstr(expr, '^\n\+').expr).matchstr(expr, '\n\+$')
    if @@ !~# '^\n*$'
      " Paste
      normal! %p
    endif
  catch /^Clojure:/
    return ''
  finally
    let @@ = reg_save
    let &selection = sel_save
    let &clipboard = cb_save
  endtry
endfunction

nnoremap <silent> <Plug>EvalPaste :<C-U>call <SID>eval_paste(v:count)<CR>

function! s:setup_eval() abort
  nmap <buffer> cep <Plug>EvalPaste
endfunction

autocmd FileType clojure call s:setup_eval()
