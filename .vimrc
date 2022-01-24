if has("win16") || has("win32") || has("win64")
  execute "set rtp^=".expand("$HOME/.vim")
endif

if has('nvim')
  " Disable Python 2
  let g:loaded_python_provider = 1
  " let g:loaded_ruby_provider = 1

  runtime! plugin/python_setup.vim
endif

set rtp+=~/.fzf

runtime bundle/vim-pathogen/autoload/pathogen.vim
execute pathogen#infect(
      \ 'bundle/{}',
      \ 'bundle_clojure/{}')

" Uses tpope's vim-sensible defaults

set hidden
set notimeout
set noswapfile
set nowritebackup
set nowrap
set nofoldenable
" lazyredraw flickers in alacritty, but perf seems ok without
set nolazyredraw
set number
set expandtab
set ignorecase
set smartcase
set noshowmode
set modeline

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
" set sidescroll=1
" Pretty character for vsplit separator
" set fillchars+=vert:│

" Save vim undo history to file, so history persists through sessions
set undofile
set undodir=~/.vim/undo
" set completeopt-=preview
set completeopt=noinsert,menuone,noselect
" set signcolumn=yes
set signcolumn=number

if has("gui_gtk2")
  set guioptions=ca
  set guifont=Consolas\ 10
endif

if has("mouse")
  set mouse=
endif

" Colors
" FIXME: Use thematic theme
if $PRESENTATION_MODE == '1'
  let g:seoul256_transparent=1
endif

let g:seoul256_srgb = 1

let g:thematic#themes = {
      \ 'seoul256': {'background': 'dark'},
      \ 'presentation': {'colorscheme': 'seoul256',
      \                  'background': 'light',
      \                  'airline-theme': 'papercolor'},
      \ }

if $PRESENTATION_MODE == '1'
  let g:thematic#theme_name = 'presentation'
else
  let g:thematic#theme_name = 'seoul256'
endif

set termguicolors

" Mappings
let mapleader = ' '
let maplocalleader = 'ö'

nnoremap ' `
nnoremap Y y$
set pastetoggle=<M-p>
nnoremap j gj
nnoremap k gk

" Save file
nnoremap ä :w<CR>

" Change active window, Alt
nnoremap <M-h> <C-w>h
nnoremap <M-j> <C-w>j
nnoremap <M-k> <C-w>k
nnoremap <M-l> <C-w>l
if has("nvim")
  tnoremap <M-h> <C-\><C-n><C-w>h
  tnoremap <M-j> <C-\><C-n><C-w>j
  tnoremap <M-k> <C-\><C-n><C-w>k
  tnoremap <M-l> <C-\><C-n><C-w>l
endif

" Close window
nnoremap <M-q> <C-w>c
inoremap <M-q> <Esc><C-w>c:echo ""<cr>
" New windows
nnoremap <M-n> <C-w>v
nnoremap <M-m> <C-w>s
" Close buffer
nnoremap <silent> <M-w> <ESC>:Bdelete<CR>

" NOTE: To make windows equal size, <C-w>=
" Resize - Ctrl + jk
nnoremap <C-j> :res -5<cr>
nnoremap <C-k> :res +5<cr>

" Unbind Ex mode
nnoremap Q <nop>

" Start interactive EasyAlign in visual mode (e.g. vip<Enter>)
vmap <Enter> <Plug>(EasyAlign)

" Vim-switch
let g:switch_mapping = "<C-s>"

nnoremap <silent> <C-b>    :<C-u>Clap buffers<cr>
" Project git files
nnoremap <silent> <C-p>    :<C-u>Clap gfiles<cr>
" Any files in current working directory (usually project folder)
nnoremap <silent> <C-P>    :<C-u>Clap files ++finder=rg --files <cr>
" Any files in cwd parent directory
nnoremap <silent> <M-p>    :<C-u>Clap files ++finder=rg --files ..<cr>

" Quick macro stuff
nnoremap § qqqqq
nnoremap ½ @q
vnoremap ½ @q
vnoremap ¤ :g/.*/norm!

" One more way to exit insert mode
inoremap <C-c> <ESC>
if has("nvim")
  tnoremap <Esc> <C-\><C-n>
endif

" Split line
nnoremap <silent> <Plug>SplitLine i<CR><Esc>k$
      \ :call repeat#set("\<Plug>SplitLine")<CR>
nmap K <Plug>SplitLine

" Leave paste mode when leaving insert mode
autocmd InsertLeave * set nopaste

set cmdheight=2

set updatetime=500

" Vim-rsi (readline insertmode bindings)
" Disable meta maps because <M-d> bindings breaks ä
let g:rsi_no_meta=1

" Airline
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

let g:airline_left_sep = ''
let g:airline_right_sep = ''
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.branch = ''
let g:airline_symbols.parse = 'ρ'

let g:airline_theme='seoul256'
let g:airline_exclude_preview = 1
let g:airline_inactive_collapse = 0
let g:airline_mode_map = {
    \ '__' : '-',
    \ 'n'  : 'N',
    \ 'i'  : 'I',
    \ 'R'  : 'R',
    \ 'c'  : 'C',
    \ 'v'  : 'v',
    \ 'V'  : 'V',
    \ '^V' : '^V',
    \ 's'  : 'S',
    \ 'S'  : 'S',
    \ '^S' : 'S',
    \ }

" let g:airline_stl_path_style = 'short'

function! AirlineInit()
  let g:airline_section_a = airline#section#create_left(['mode', 'crypt', 'paste', 'capslock', 'iminsert'])
  " hunks disabled because it's empty for non-active buffers
  let g:airline_section_b = airline#section#create(['branch'])
  let g:airline_section_c = airline#section#create(['%<', 'file', 'readonly'])
  let g:airline_section_gutter = airline#section#create(['%='])
  let g:airline_section_x = airline#section#create_right(['tagbar'])
  let g:airline_section_y = airline#section#create_right([])
  let g:airline_section_z = airline#section#create(['windowswap', 'linenr', ':%3v '])
endfunction
autocmd VimEnter * call AirlineInit()

" vim.diagnostic default is 10?
let g:gitgutter_sign_priority=5

" FZF

let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

" Clojure options
autocmd BufNewFile,BufReadPost *.boot setfiletype clojure

" ' and ` are used alone in Clojure
au FileType clojure let b:delimitMate_quotes = "\""

" Iced
let g:iced_formatter = 'zprint'
let g:iced_enable_auto_indent = v:false
let g:iced#nrepl#skip_evaluation_when_buffer_size_is_exceeded = v:true
" let g:iced_enable_clj_kondo_analysis = v:true
" let g:iced_enable_clj_kondo_local_analysis = v:true
let g:iced#buffer#stdout#max_line = 10000
let g:iced_enable_auto_document = ''
let g:iced#selector#search_order = ['clap']


" Lispwords settings on ~/.vim/after/ftplugin/clojure.vim
let g:clojure_align_multiline_strings = 0
let g:clojure_maxlines = 200

" let g:leiningen_no_auto_repl = 1
let g:rainbow_active = 0
let g:rainbow_conf = {
      \ 'ctermfgs': ['204', '179', '146', '72', '225', '113', '75'],
      \ 'guifgs': [
      \     '#d7875f',
      \     '#d75f87',
      \     '#d7d700',
      \     '#5fafff',
      \     '#87d75f'
      \ ],
      \ 'separately': {
      \   'markdown': 0,
      \   'html': 0,
      \   'fzf': 0,
      \ }
      \ }

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

" autocmd FileType json syntax match Comment +\/\/.\+$+

" R
let vimrplugin_term="urxvt"

let g:sql_type_default = 'pgsql'
let g:ftplugin_sql_omni_key = '<C-j>'

autocmd VimResized  *    exe "normal! \<c-w>="

let g:lua_complete_omni = 1

let g:vcoolor_disable_mappings = 1
nnoremap <silent><leader>c  :VCoolor<CR>

augroup markdown
  autocmd!
  autocmd FileType markdown setlocal spell spelllang=en_us
  autocmd FileType markdown set cc=80
  autocmd FileType markdown syntax match urls /https\?:\/\/\(\w\+\(:\w\+\)\?@\)\?\([A-Za-z][-_0-9A-Za-z]*\.\)\{1,}\(\w\{2,}\.\?\)\{1,}\(:[0-9]\{1,5}\)\?\S*/ contains=@NoSpell
  autocmd FileType markdown syntax match javapkg /\(java\|org\)\(\.[A-Za-z]\+\)\+/ contains=@NoSpell
augroup END

let g:magit_show_help=0

nnoremap <leader>g :Grepper -tool git<cr>
nnoremap <leader>a :Grepper -tool ag<cr>
nmap gs <plug>(GrepperOperator)
xmap gs <plug>(GrepperOperator)

if !exists('g:grepper')
  let g:grepper = {}
endif
let g:grepper.prompt_quote = 2

let g:float_preview#docked = 0
let g:float_preview#max_width = 70

function! DisableExtras()
  call nvim_win_set_option(g:float_preview#win, 'number', v:false)
  call nvim_win_set_option(g:float_preview#win, 'relativenumber', v:false)
  call nvim_win_set_option(g:float_preview#win, 'cursorline', v:false)
endfunction

autocmd User FloatPreviewWinOpen call DisableExtras()

autocmd FileType git,gitcommit,gitrebase,fugitiveblame nnoremap <buffer> <M-w> <C-w>c

autocmd BufRead,BufNewFile Jenkinsfile set ft=groovy

" Ncm2

let g:ncm2#complete_delay = 400

autocmd BufEnter * call ncm2#enable_for_buffer()

" When the <Enter> key is pressed while the popup menu is visible, it only
" hides the menu. Use this mapping to close the menu and also start a new
" line.
inoremap <expr> <CR> (pumvisible() ? "\<c-y>\<cr>" : "\<CR>")

" Use <TAB> to select the popup menu:
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Clap

let g:clap_layout = { 'relative': 'editor' }
let g:clap_disable_run_rooter = 0
" let g:clap_open_preview = 'never'
let g:clap_preview_direction = 'UD'
" Close clap window using esc, instead of changing to normal mode.
let g:clap_insert_mode_only = v:true
let g:clap_multi_selection_warning_silent = 1

" - Disable close window and delete buffer binds on clap input
" - Disable change window binds
" These would break clap floating window.
" Even though M-w and move are only bound on normal mode, they still affect
" clap input?
" TODO: Move these to ftplugin after file?
autocmd FileType clap_input inoremap <silent> <buffer> <M-q> <Esc>:<c-u>call clap#handler#exit()<CR>
autocmd FileType clap_input inoremap <silent> <buffer> <M-w> <Esc>:<c-u>call clap#handler#exit()<CR>
autocmd FileType clap_input inoremap <silent> <buffer> <M-h> <nop>
autocmd FileType clap_input inoremap <silent> <buffer> <M-j> <nop>
autocmd FileType clap_input inoremap <silent> <buffer> <M-k> <nop>
autocmd FileType clap_input inoremap <silent> <buffer> <M-l> <nop>
" By default only on normal mode
" Goes to normal, invoke action, back to insert
autocmd FileType clap_input inoremap <silent> <buffer> <S-Tab> <Esc>:<c-u>call clap#action#invoke()<CR>i
" Note: If stuck with unfocused Clap floating window, run :Clap to return the
" focus and close normally.

" nmap <Leader>z <Plug>(MaximizeWin)

" nmap <silent> <Leader>B <Plug>(ClearAllWindows)
" nmap <silent> <Leader>b <Plug>(ClearBufferList)

" in init.vim
lua << EOF
  local lspconfig = require 'lspconfig'

  local on_attach = function(client, bufnr)
    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

    -- Enable completion triggered by <c-x><c-o>
    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    local opts = { noremap=true, silent=true }

    -- See `:help vim.lsp.*` for documentation on any of the below functions
    -- FIXME: Not used with clojure-lsp?
    --buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    --buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    -- FIXME: Conflict with split line
    buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
    -- FIXME: Not used with clojure-lsp?
    -- buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    -- FIXME: Conflict with resize
    buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
    buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
    buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
    -- FIXME: Not used with clojure-lsp?
    -- buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    -- Works with e.g. let binding name, not defn?
    buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    buf_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
    buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
    buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
    buf_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
    buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

  end

  -- Confiure clojure-lsp setup to return parent project folder
  -- for multimodule projects, like Reitit.
  local lspconfig_util = require 'lspconfig/util'
  local root_pattern = function(...)
    local patterns = vim.tbl_flatten { ... }
    local function matcher(path)
      for _, pattern in ipairs(patterns) do
        for _, p in ipairs(vim.fn.glob(lspconfig_util.path.join(path, pattern), true, true)) do
          if lspconfig_util.path.exists(p) then
            -- Unix paths only.
            -- Ignore the deps file if path is e.g. modules/reitit-core/project.clj
            if not p:match("modules/[^/]+/[^/]+$") then
              return path
            end
          end
        end
      end
    end
    return function(startpath)
      return lspconfig_util.search_ancestors(startpath, matcher)
    end
  end

  lspconfig.clojure_lsp.setup {
    on_attach = on_attach,
    flags = {
        debounce_text_change = 150,
    },
    root_dir = root_pattern('project.clj', 'deps.edn', 'build.boot', 'shadow-cljs.edn', '.git'),
  }

  local signs = { Error = "E ", Warn = "W ", Hint = "H ", Info = "I " }
  for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
  end

  require'nvim-treesitter.configs'.setup {
  -- One of "all", "maintained" (parsers with maintainers), or a list of languages
  ensure_installed = { "clojure" },

  -- Install languages synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- List of parsers to ignore installing
  ignore_install = {},

  highlight = {
    -- `false` will disable the whole extension
    enable = false,

    -- list of language that will be disabled
    disable = {},

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
  incremental_selection = {
    enable = false,
    keymaps = {
      init_selection = "gnn",
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm",
    },
  },
  -- Clojure doesn't support this?
  indent = {
    enable = true,
  },
  rainbow = {
    enable = { "clojure" },
    extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
    max_file_lines = nil, -- Do not enable for files with more than n lines, int
    colors = {
      '#d7875f',
      '#d75f87',
      '#d7d700',
      '#5fafff',
      '#87d75f'
    },
    termcolors = {
      '204', '179', '146', '72', '225', '113', '75'
    }
  }
}
EOF
