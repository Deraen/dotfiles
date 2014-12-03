function! EnableAnsiEsc()
  let buf=bufnr("%")
  if !exists("g:AnsiEsc_enabled_{buf}") || !g:AnsiEsc_enabled_{buf}
    call AnsiEsc#AnsiEsc(0)
  else
    call AnsiEsc#AnsiEsc(1)
  endif
endfunc

autocmd BufEnter    *    if &buftype == 'quickfix' | call EnableAnsiEsc() | endif
autocmd BufWinEnter *    if &buftype == 'quickfix' | call EnableAnsiEsc() | endif
