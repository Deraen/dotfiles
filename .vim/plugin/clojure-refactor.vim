function! s:ReorderCljNsRequire()
  normal! gg
  normal "gyaf
  if @g =~ "\(:require"
    call search(':require')
    normal elKm<
    normal Bh%m>K
    silent '<,'>!sort
    normal '<kJ
    normal '>J$==
  endif
endfunc

nnoremap <silent> <Plug>CljRefactorSortNs :<C-U>call <SID>ReorderCljNsRequire()<CR>

function! s:set_up_clj_refactor() abort
  nmap <buffer> <F4> <Plug>CljRefactorSortNs
endfunction

augroup ClojureRefactor
  autocmd!
  autocmd FileType clojure call s:set_up_clj_refactor()
augroup END
