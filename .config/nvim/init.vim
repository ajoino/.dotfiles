let g:python3_host_prog = "/usr/bin/python3"
set nocompatible
set number relativenumber
syntax on
set encoding=utf-8
set ruler
set breakindent
set cursorline
set title
set confirm
set wrap lbr
filetype plugin on
filetype indent on
set showbreak=..

" Generic settings
set tabstop=4
set softtabstop=4
set shiftwidth=4
set list
set listchars=tab:>.,trail:.,extends:#,nbsp:.
set path+=**
set wildmenu


" :Rpdf command to read pdfs
:command! -complete=file -nargs=1 Rpdf :r !pdftotext -nopgbrk <q-args> -

call plug#begin('~/.config/nvim/plugged')
Plug 'da-h/AirLatex.vim', {'do': ':UpdateRemotePlugins'}
Plug 'lervag/vimtex', {'for': 'tex'}
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
Plug 'KeitaNakamura/tex-conceal.vim', {'for': 'tex'}
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'tpope/vim-surround'
Plug 'rakr/vim-one'
Plug 'lifepillar/vim-solarized8'
Plug 'kaicataldo/material.vim'
Plug 'sjl/badwolf'
Plug 'maverickg/stan.vim', {'for': 'stan'}
Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins', 'for': 'python'}
Plug 'davidhalter/jedi-vim'
Plug 'ncm2/ncm2', {'for': 'python'}
Plug 'roxma/nvim-yarp'
Plug 'ncm2/ncm2-jedi'
" Words in buffer completion
Plug 'ncm2/ncm2-bufword'
" Filepath completion
Plug 'ncm2/ncm2-path'
Plug 'mrtazz/simplenote.vim'
Plug 'iamcco/markdown-preview.nvim', {'do': { -> mkdp#util#install()}, 'for': ['markdown', '', 'vim-plug']}
Plug 'dpelle/vim-LanguageTool'
" Haskell
Plug 'neovimhaskell/haskell-vim'
" To save with sudo priviliges
Plug 'lambdalisue/suda.vim'
call plug#end()

" ncm2 settings
autocmd BufEnter * call ncm2#enable_for_buffer()
set completeopt=menuone,noselect,noinsert
set shortmess+=c
inoremap <c-c> <ESC>
" make it fast
let ncm2#popup_delay = 5
let ncm2#complete_length = [[1, 1]]
" Use new fuzzy based matches
let g:ncm2#matcher = 'substrfuzzy'
" Python specific configuration, follows some parts of PEP8
au Filetype python set
			\ tabstop=4
			\ softtabstop=4
			\ shiftwidth=4
			\ expandtab
			\ autoindent
			\ smarttab
			\ fileformat=unix
			\ colorcolumn=90
			\ foldenable
			\ foldmethod=indent
			\ foldlevel=99

let g:pyindent_open_paren = '&sw * 2'
let g:pyindent_continue = '&sw * 2'

nnoremap <space> za

au Filetype tex set
			\ tabstop=4
			\ softtabstop=4
			\ shiftwidth=4
			\ autoindent
			\ conceallevel=2
let g:netrw_liststyle=3
let g:vimtex_enable=1
let g:vimtex_quickfix_mode=0
let g:tex_flavor='latex'
let g:tex_conceal='abdmg'
hi conceal guibg=gray12 guifg=orange
let g:jedi#auto_initialization = 1
let g:jedi#completions_enabled = 0
let g:jedi#auto_vim_configuration = 0
let g:jedi#smart_auto_mappings = 0
let g:jedi#popup_on_dot = 0
let g:jedi#completions_command = ""
let g:jedi#show_call_signatures = "2"
let g:jedi#show_call_signatures_delay = 0
let g:jedi#use_splits_not_buffers = 0
let g:jedi#show_call_signatures_modes = 'ni'  " ni = also in normal mode
let g:jedi#enable_speed_debugging=0

au Filetype markdown set conceallevel=2
let g:vim_markdown_folding_disabled=1

let g:UltisnipsExpandTrigger = '<tab>'

let g:semshi#no_default_builtin_highlight = v:true

let g:languagetool_jar = '$HOME/LanguageTool-4.9.1/languagetool-commandline.jar'

set termguicolors
colorscheme badwolf

" Movement commands
nnoremap j gj
nnoremap k gk
nnoremap gv `[v`]
nnoremap Y y$

nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>

abbrev teh the
