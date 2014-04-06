autocmd FileType clojure nunmap <buffer> K
autocmd FileType clojure nmap <buffer> <F2>  <Plug>FireplaceK
autocmd FileType clojure nmap <buffer> <F3>  <Plug>FireplaceSource

function! s:Refresh(bang, ns)
  let cmd = (('(>refresh)'))
  try
    silent! write
    call fireplace#session_eval(cmd)
    return ''
  catch /^Clojure:.*/
    return ''
  endtry
endfunction

function! s:setup_refresh()
  command! -buffer -bar -bang -complete=customlist,fireplace#ns_complete -nargs=? Refresh :exe s:Refresh(<bang>0, <q-args>)
  nnoremap <silent><buffer> cpf :Refresh<CR>
endfunction

autocmd FileType clojure call s:setup_refresh()

function! s:MidjeTest(bang, ns)
  let cmd = (("(use 'midje.repl)(midje.repl/load-facts :all)"))
  try
    call fireplace#session_eval(cmd)
    return ''
  catch /^Clojure:.*/
    return ''
  endtry
endfunction

function! s:setup_test()
  command! -buffer -bar -bang -complete=customlist,fireplace#ns_complete -nargs=? MidjeTest :exe s:MidjeTest(<bang>0, <q-args>)
  nnoremap <silent><buffer> cpt :MidjeTest<CR>
endfunction

autocmd FileType clojure call s:setup_test()
