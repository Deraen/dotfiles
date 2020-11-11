" Remove trailing whitespaces
function! s:StripTrailingWhitespaces()
  let l = line(".")
  let c = col(".")
  silent! %s/\s\+$//e
  call cursor(l, c)
endfun

nnoremap <silent> <Plug>StripTrailingSpaces :<C-U>call <SID>StripTrailingWhitespaces()<CR>

highlight ExtraWhitespace ctermfg=15 ctermbg=124

" Hightlight trailing spaces in normal mode
autocmd InsertEnter * match
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

augroup TrailingSpaces
  nmap <leader>dt <Plug>StripTrailingSpaces
augroup END
