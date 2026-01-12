" Check highlighting group of current char
function! SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

let g:vim_json_syntax_conceal = 0

" Disable sql ft default completion maps (<C-c> by default)
let g:omni_sql_no_default_maps = 1

autocmd VimResized * exe "normal! \<c-w>="

augroup markdown
  autocmd!
  autocmd FileType markdown setlocal spell spelllang=en_us
  autocmd FileType markdown set cc=80
  autocmd FileType markdown syntax match urls /https\?:\/\/\(\w\+\(:\w\+\)\?@\)\?\([A-Za-z][-_0-9A-Za-z]*\.\)\{1,}\(\w\{2,}\.\?\)\{1,}\(:[0-9]\{1,5}\)\?\S*/ contains=@NoSpell
  autocmd FileType markdown syntax match javapkg /\(java\|org\)\(\.[A-Za-z]\+\)\+/ contains=@NoSpell
augroup END

autocmd FileType git,gitcommit,gitrebase,fugitiveblame nnoremap <buffer> <M-w> <C-w>c

autocmd BufRead,BufNewFile Jenkinsfile set ft=groovy

if !exists('g:grepper')
  let g:grepper = {}
endif
let g:grepper.prompt_quote = 2

function! s:GotoFirstFloat() abort
  for w in range(1, winnr('$'))
    let c = nvim_win_get_config(win_getid(w))
    if c.focusable && !empty(c.relative)
      execute w . 'wincmd w'
    endif
  endfor
endfunction
noremap <c-w><space> :<c-u>call <sid>GotoFirstFloat()<cr>
