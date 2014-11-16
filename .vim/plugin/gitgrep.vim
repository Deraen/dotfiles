function! Gitgrep(arg)
  setlocal grepprg=git\ grep\ --no-color\ --line-number\ -n\ $*
  silent execute ':grep! '.a:arg
  silent cwin
  redraw!
endfunction

command! -nargs=1 -complete=buffer Gitgrep call Gitgrep(<q-args>)
" let grepprg='git grep --no-color --line-number'

" Search in project for these words
nnoremap <silent> <Plug>GitGrepFIXME :<C-U>Gitgrep FIXME<CR>
nnoremap <silent> <Plug>GitGrepTODO :<C-U>Gitgrep TODO<CR>
" Search for word under the cursor
nnoremap <silent> <Plug>GitGrepWord :<C-U>exec ':silent Gitgrep ' . expand('<cword>')<CR>

nnoremap <Plug>GitGrepStart :<C-U>Gitgrep<space>

augroup GitGrep
  nmap <space>/f <Plug>GitGrepFIXME
  nmap <space>/t <Plug>GitGrepTODO
  nmap <space>/w <Plug>GitGrepWord
  nmap gG        <Plug>GitGrepWord
  nmap <space>q  <Plug>GitGrepStart
augroup END
