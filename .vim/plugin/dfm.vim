" Toggle buffer fullscreen
let g:dfm_fullscreen=0
let g:dfm_nd=0

function! s:Fullscreen()
  if g:dfm_nd
    call NoDistraction()
  endif
  if g:dfm_fullscreen
    tab close
    set showtabline=1
  else
    tab split
    set showtabline=0
  endif
  let g:dfm_fullscreen=!g:dfm_fullscreen
endfunction

nnoremap <silent> <Plug>Dfm :<C-U>call <SID>Fullscreen()<CR>

augroup Dfm
  nmap <M-f> <Plug>Dfm
augroup END
