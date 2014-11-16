if !has("unix")
  finish
endif

function! s:ColorPicker(insert)
  let color = expand('<cword>')
  let @z = system("zenity --color-selection --color " . shellescape(color) . " | cut -c 2-3,6-7,10-11 | tr -d \"\n\"")
  if strlen(@z) != 0
    let @z = '#' . @z
    if a:insert == 0
      normal! viw"zP
    else
      normal! "zp
    endif
  endif
endfunction

nnoremap <silent> <Plug>ColorPicker :<C-U>call <SID>ColorPicker(0)<cr>
" inoremap <silent> <Plug>ColorPickerI <C-o>:call ColorPicker(1)<cr>

augroup ColorPicker
  nmap <space>c <Plug>ColorPicker
  " inoremap <silent>c <Plug>ColorPickerI
augroup END
