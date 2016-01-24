function! EnableAnsiEsc()
  call Colorizer#DoColor(0, 1, line('$'))
endfunc

autocmd BufEnter    *    if &buftype == 'quickfix' | call EnableAnsiEsc() | endif
autocmd BufWinEnter *    if &buftype == 'quickfix' | call EnableAnsiEsc() | endif
