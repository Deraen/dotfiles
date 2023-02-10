" Default is j/k
inoremap <silent> <buffer> <C-n> <C-R>=clap#navigation#linewise_scroll('down')<CR>
inoremap <silent> <buffer> <C-p> <C-R>=clap#navigation#linewise_scroll('up')<CR>

inoremap <silent> <buffer> <C-b> <nop>
inoremap <silent> <buffer> <C-o> <nop>

" - Disable close window and delete buffer binds on clap input
" - Disable change window binds
" These would break clap floating window.
" Even though M-w and move are only bound on normal mode, they still affect
" clap input?
inoremap <silent> <buffer> <M-q> <Esc>:<c-u>call clap#handler#exit()<CR>
inoremap <silent> <buffer> <M-w> <Esc>:<c-u>call clap#handler#exit()<CR>
inoremap <silent> <buffer> <M-h> <nop>
inoremap <silent> <buffer> <M-j> <nop>
inoremap <silent> <buffer> <M-k> <nop>
inoremap <silent> <buffer> <M-l> <nop>

" Goes to normal, invoke action, back to insert
inoremap <silent> <buffer> <S-Tab> <Esc>:<c-u>call clap#action#invoke()<CR>i
