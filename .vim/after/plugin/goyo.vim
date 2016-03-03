function! s:goyo_enter()
  set noshowmode
  set noshowcmd
  set scrolloff=10
  set wrap
  set linebreak
  set number
  highligh LineNr ctermfg=235 ctermbg=233
  augroup goyo_resize
    autocmd!
    autocmd VimResized * exe "Goyo x85%"
  augroup END
endfunction

function! s:goyo_leave()
  augroup goyo_resize
    autocmd!
  augroup END
endfunction

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()
