" Remove trailing whitespaces
function! s:StripTrailingWhitespaces()
  let l = line(".")
  let c = col(".")
  silent! %s/\s\+$//e
  call cursor(l, c)
endfun

nnoremap <silent> <Plug>StripTrailingSpaces :<C-U>call <SID>StripTrailingWhitespaces()<CR>

" Hightlight trailing spaces in normal mode
autocmd InsertEnter * match
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

augroup TrailingSpaces
  nmap <space>dt <Plug>StripTrailingSpaces
augroup END
