""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vundle
" git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
filetype off
set rtp+=~/.vim/bundle/vundle
call vundle#rc()


" Bundle 'LaTeX-Box-Team/LaTeX-Box'
" Bundle 'PeterRincker/vim-argumentative' " kielet?
" Bundle 'Shougo/unite-outline'
" Bundle 'Shougo/unite.vim'
" Bundle 'arecarn/crunch'
" Bundle 'b4winckler/vim-angry'
" Bundle 'baabelfish/a.vim'
" Bundle 'chrisbra/NrrwRgn'
" Bundle 'dag/vim-fish'
" Bundle 'glts/vim-textobj-comment'
" Bundle 'jwhitley/vim-matchit'
" Bundle 'kana/vim-textobj-entire'
" Bundle 'kana/vim-textobj-indent'
" Bundle 'kana/vim-textobj-user'
" Bundle 'kurkale6ka/vim-pairs'
" Bundle 'mattn/emmet-vim'
" Bundle 'mhinz/vim-signify'
" Bundle 'mhinz/vim-startify'
" Bundle 'mrtazz/DoxygenToolkit.vim'
" Bundle 'scottymoon/vim-twilight'
" Bundle 'tsukkee/unite-tag'
" Bundle 'vim-scripts/VisIncr'
" Bundle 'vim-scripts/ZoomWin'
" Bundle 'vim-scripts/django.vim'
Bundle 'AndrewRadev/switch.vim'
Bundle 'SirVer/ultisnips'
Bundle 'Valloric/YouCompleteMe'
Bundle 'baabelfish/vim-droid256'
Bundle 'bling/vim-airline'
Bundle 'drmikehenry/vim-fixkey'
Bundle 'gmarik/vundle'
Bundle 'gregsexton/gitv'
Bundle 'junegunn/vim-easy-align'
Bundle 'kana/vim-arpeggio'
Bundle 'pangloss/vim-javascript'
Bundle 'paradigm/SkyBison'
Bundle 'rainbow_parentheses.vim'
Bundle 'scrooloose/syntastic'
Bundle 'sjl/gundo.vim'
Bundle 'terryma/vim-multiple-cursors'
Bundle 'tomasr/molokai'
Bundle 'tomtom/tcomment_vim'
Bundle 'tpope/vim-abolish'
Bundle 'tpope/vim-dispatch'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-markdown'
Bundle 'tpope/vim-repeat'
Bundle 'tpope/vim-sleuth'
Bundle 'tpope/vim-surround'
Bundle 'vim-scripts/Bck'
Bundle 'vim-scripts/L9'
Bundle 'vim-scripts/VimClojure'
Bundle 'vim-scripts/Vimchant'
Bundle 'wincent/Command-T'
" Bundle 'vim-scripts/slimv.vim' "Korvaa vimClojuren?

filetype plugin indent on
setlocal spell spelllang=en_us

if has("multi_byte")
  if &termencoding == ""
    let &termencoding = &encoding
  endif
  set encoding=utf-8
  setglobal fileencoding=utf-8
  scriptencoding utf-8
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set autoread
set backspace=indent,eol,start
set clipboard+=unnamedplus
set expandtab
set fillchars+=vert:│
set gdefault
set hidden
set history=100
set ignorecase
set incsearch
set laststatus=2
set lazyredraw
set listchars=""
set listchars=tab:→\ ,trail:·,extends:↷,precedes:↶,nbsp:█
set nobackup
set noerrorbells
set nofoldenable
set noshowmode
set nospell
set noswapfile
set notimeout
set novisualbell
set nowrap
set nrformats-=octal
set shortmess+=filmnrxoOtTI
set smartcase
set smartindent
set smarttab
set ttimeout
set ttimeoutlen=0
set wildignore+=*/bower_components/*,*/node_modules/*,*/site-packages/*,*/tmp/*,*.so,*.swp,*.zip,*/doxygen/*,*.o,*.pyc,*.aux,*.toc,*.tar,*.gz,*.svg,*.mdr,*.mdzip,*.blg,*.bbl,*.out,*.log,*.zip,*.pdf,*.bst,*.jpeg,*.jpg,*.png,*.a,*.so,*.exe,*.dll,*.bak,*.,*.class,*.meta,*.lock,*.orig,*.jar,*/hg/*,git/*,*/bzr/*
set wildmenu
set wrapmargin=0
" Tää on oikeesti kiva
set relativenumber

" Voi jäytää ehkä
set regexpengine=0

" Tab settings
set numberwidth=2
set shiftwidth=2
set softtabstop=2


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Colors
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
syntax on
if has("gui_running")
  colorscheme twilight
elseif &t_Co == 256 
  colorscheme molokai
endif

" Color erase fix
if &term =~ '256color'
  set t_ut=
endif


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Mappings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let mapleader = 'ö'
" Pakko korjaukset
nnoremap ' `
nnoremap Y y$
set pastetoggle=<M-p>
nnoremap j gj
nnoremap k gk

" Ikkunoiden mälväys altin kanssa
nnoremap <M-h> h
nnoremap <M-j> j
nnoremap <M-k> k
nnoremap <M-l> l
nnoremap <M-H> H
nnoremap <M-J> J
nnoremap <M-K> K
nnoremap <M-L> L
nnoremap <M-q> <C-w>c
nnoremap <M-c> :tabclose<cr>:echo ""<cr>
nnoremap <M-n> <C-w>v
nnoremap <M-m> <C-w>s
nnoremap <M-w> <C-w><C-w>

" Liikuttaa parametreja
nmap <; <Plug>Argumentative_MoveLeft
nmap >; <Plug>Argumentative_MoveRight

" Undohistoria. Itse en käytä.
nnoremap <F5> :GundoToggle<CR>

" Sama kun sublimen C-r
nnoremap <silent><space>f m':Unite -hide-status-line outline<CR>
" Sama kun sublimen C-p
nnoremap <silent><space>p :CommandT<CR>

" Projektissa ettimiseen Ackilla
" <C-r><C-w> ottaa kursorin alla olevan sanan -> :h <C-r>
nnoremap <silent><space>bf :Bck FIXME<CR>
nnoremap <silent><space>bt :Bck TODO<CR>
nnoremap <silent><space>bw :Bck <C-r><C-w><CR>

" Lisää ja vähentää seuraavasta numerosta
nnoremap + <C-a>
nnoremap - <C-x>

" å togglee kommentin
nnoremap <silent>å :TComment<CR>
vnoremap å :TComment<CR>

" Näppärä nopea makronappi
nnoremap § qqqqq
nnoremap ½ @q
vnoremap ½ @q
vnoremap ¤ :g/.*/norm! 

" Avaa git diffin
nnoremap <silent><space>t :Gitv<CR>
inoremap <C-c> <ESC>

let g:ycm_key_list_select_completion = ['<C-Space>', '<Down>']
let g:UltiSnipsExpandTrigger="<TAB>"
" let g:UltiSnipsListSnippets="<c-$>"
" let g:UltiSnipsJumpForwardTrigger="<c-j>"
" let g:UltiSnipsJumpBackwardTrigge="<c-k>"
