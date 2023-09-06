if has('nvim')
  let g:loaded_ruby_provider = 0
  let g:loaded_node_provider = 0
  let g:loaded_perl_provider = 0
endif

set notimeout
set noswapfile
set nowritebackup
set nowrap
set nofoldenable
set number
set expandtab
set ignorecase
set smartcase
set noshowmode
set noshowcmd

" Display whitespaces as nice unicode chars
set list
set listchars=""
set listchars=tab:→\ ,trail:·,extends:↷,precedes:↶,nbsp:█
" Enable g by default on substitute - that is, all matches in line are
" replaced. use s///g to substitute only first match.
set gdefault
" Shorten file messages:
" m [Modiefied] -> [+], r [readonly] -> [RO], I no welcome message
" c no match x of y for completion
set shortmess+=mrIc
" Command completion. Complete till longest common string and show wildmenu.
set wildmode=longest:full
" Ignorecase when completing filenames on command prompt. e.g. ~/.xres -> ~/.Xresources
set wildignorecase
" Disable text and comment wrapping
set formatoptions-=tc
" Force fast tty. Should already be on when term is rxvt.
if !has('nvim')
  set ttyfast
  set ttyscroll=1
endif

" Save vim undo history to file, so history persists through sessions
set undofile
set undodir=~/.cache/vim/undo
set completeopt=noinsert,menuone,noselect
set signcolumn=number

" Terminal
set scrollback=50000

" Disable mouse
set mouse=

" Read project .nvim.lua / .nvimrc / .exrc
set exrc

let g:seoul256_srgb = 1
" colorschema seoul256
colorscheme kanagawa-dragon

set termguicolors

" set cmdheight=2
" CursorHold autocmd & swapfile (not enabled)
" set updatetime=500

" Mappings
let mapleader = ' '
let maplocalleader = 'ö'

nnoremap ' `
nnoremap Y y$
nnoremap j gj
nnoremap k gk

" Save file
nnoremap ä :w<CR>

" Close window
nnoremap <M-q> <C-w>c
inoremap <M-q> <Esc><C-w>c:echo ""<cr>
" New windows
nnoremap <M-n> <C-w>v
nnoremap <M-m> <C-w>s
" Close buffer
nnoremap <silent> <M-w> <ESC>:Bdelete<CR>

" NOTE: To make windows equal size, <C-w>=

" Unbind Ex mode
nnoremap Q <nop>

" Start interactive EasyAlign in visual mode (e.g. vip<Enter>)
vmap <Enter> <Plug>(EasyAlign)

" Vim-switch
" let g:switch_mapping = "<C-s>"

" nnoremap <silent> <C-b>    :<C-u>Clap buffers<cr>
" Project git files
" nnoremap <silent> <C-p>    :<C-u>Clap! git_files<cr>
" Any files in current working directory (usually project folder)
" nnoremap <silent> <M-p>    :<C-u>Clap! files ++finder=rg --files <cr>

" Quick macro stuff
nnoremap § qqqqq
nnoremap ½ @q
vnoremap ½ @q

" One more way to exit insert mode
inoremap <C-c> <ESC>
if has("nvim")
  tnoremap <Esc> <C-\><C-n>
endif

" Split line
nnoremap <silent> <Plug>SplitLine i<CR><Esc>k$
      \ :call repeat#set("\<Plug>SplitLine")<CR>
" FIXME: Find new binding
" nmap K <Plug>SplitLine

" Vim-rsi (readline insertmode bindings)
" Disable meta maps because <M-d> bindings breaks ä
let g:rsi_no_meta=1

" Clojure options
autocmd BufNewFile,BufReadPost *.boot setfiletype clojure
autocmd BufNewFile,BufReadPost *.bb setfiletype clojure

" Iced
let g:iced_formatter = 'zprint'
let g:iced_enable_auto_indent = v:false
" let g:iced#nrepl#skip_evaluation_when_buffer_size_is_exceeded = v:true
let g:iced#nrepl#enable_sideloader = v:true
" let g:iced_enable_clj_kondo_analysis = v:true
" let g:iced_enable_clj_kondo_local_analysis = v:true
let g:iced#buffer#stdout#max_line = 10000
let g:iced_enable_auto_document = ''
let g:iced#selector#search_order = ['clap']
let g:iced#source_root = '/home/juho/.vim/bundle_clojure/vim-iced'

" Lispwords settings on ~/.vim/after/ftplugin/clojure.vim
let g:clojure_align_multiline_strings = 0
let g:clojure_maxlines = 200

" These confict with my window bindings, tpopes plugin already has these bound
" to rational keys
let g:sexp_mappings = {
      \ 'sexp_swap_list_backward': '',
      \ 'sexp_swap_list_forward': '',
      \ 'sexp_swap_element_backward': '',
      \ 'sexp_swap_element_forward': '',
      \ 'sexp_move_to_prev_element_head': '',
      \ 'sexp_move_to_next_element_head': '',
      \ 'sexp_move_to_prev_element_tail': '',
      \ 'sexp_move_to_next_element_tail': '',
      \ 'sexp_raise_list':                '<LocalLeader>o',
      \ 'sexp_raise_element':             '<LocalLeader>O',
      \}
      " \ 'sexp_indent': '',
      " \ 'sexp_indent_top': '',
let g:sexp_enable_insert_mode_mappings = 0

" Check highlighting group of current char
function! SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

let g:vim_json_syntax_conceal = 0

let g:sql_type_default = 'pgsql'
let g:ftplugin_sql_omni_key = '<C-j>'

autocmd VimResized  *    exe "normal! \<c-w>="

let g:vcoolor_disable_mappings = 1
" nnoremap <silent><leader>c  :VCoolor<CR>

augroup markdown
  autocmd!
  autocmd FileType markdown setlocal spell spelllang=en_us
  autocmd FileType markdown set cc=80
  autocmd FileType markdown syntax match urls /https\?:\/\/\(\w\+\(:\w\+\)\?@\)\?\([A-Za-z][-_0-9A-Za-z]*\.\)\{1,}\(\w\{2,}\.\?\)\{1,}\(:[0-9]\{1,5}\)\?\S*/ contains=@NoSpell
  autocmd FileType markdown syntax match javapkg /\(java\|org\)\(\.[A-Za-z]\+\)\+/ contains=@NoSpell
augroup END

let g:magit_show_help=0

autocmd FileType git,gitcommit,gitrebase,fugitiveblame nnoremap <buffer> <M-w> <C-w>c

autocmd BufRead,BufNewFile Jenkinsfile set ft=groovy

nnoremap <leader>gg :Grepper -tool git<cr>
nnoremap <leader>ga :Grepper -tool ag<cr>
nmap <leader>gs <plug>(GrepperOperator)
xmap <leader>gs <plug>(GrepperOperator)

if !exists('g:grepper')
  let g:grepper = {}
endif
let g:grepper.prompt_quote = 2
