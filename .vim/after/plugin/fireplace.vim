autocmd FileType clojure nmap <buffer> <F2>  <Plug>FireplaceK
autocmd FileType clojure nmap <buffer> <F3>  <Plug>FireplaceSource

" Variant of eval where result of expression (outermost form) is pasted onto the document
" following the evaluated form.
" Use case: using VIM like REPL during training presentations
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

" Source: http://blog.venanti.us/clojure-vim/
function! s:TestToplevel() abort
    "Eval the toplevel clojure form (a deftest) and then test-var the result."
    normal! ^
    let line1 = searchpair('(','',')', 'bcrn', g:fireplace#skip)
    let line2 = searchpair('(','',')', 'rn', g:fireplace#skip)
    let expr = join(getline(line1, line2), "\n")
    let var = fireplace#session_eval(expr)
    let result = fireplace#echo_session_eval("(clojure.test/test-var " . var . ")")
    return result
endfunction

nnoremap <silent> <Plug>TestToplevel :<C-U>call <SID>TestToplevel()<CR>

function! s:set_up() abort
  nmap <buffer> cep <Plug>EvalPaste
  " Remove eval result lines
  nmap <buffer> ced :%g/^;; =>/d<CR>

  nmap <buffer> cpt <Plug>TestToplevel
endfunction

augroup fireplace_eval_paste
  autocmd!
  autocmd FileType clojure call s:set_up()
augroup END
