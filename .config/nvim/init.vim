set encoding=utf-8
scriptencoding utf-8
let g:python3_host_prog = "/usr/bin/python3"
set nocompatible
set number relativenumber
syntax on
set ruler
set breakindent
set cursorline
set title
set confirm
set wrap lbr
filetype on
filetype plugin on
filetype indent on
set showbreak=..

" Generic settings
set tabstop=4
set softtabstop=4
set shiftwidth=4
set list
" Read 'help listchars' for more info
set listchars=tab:\|\ ,trail:.,extends:#,nbsp:. " ,multispace:\ ,lead:\ 
set path+=**
set wildmenu
set termguicolors

" Transparent background
 au ColorScheme * hi Normal ctermbg=none guibg=none
 au ColorScheme * hi EndOfBuffer ctermbg=none guibg=none
 au ColorScheme * hi StatusLine ctermbg=darkmagenta guibg=darkmagenta
 au ColorScheme * hi LineNr ctermbg=none guibg=none

 au FileType fish colorscheme fish-default

" :Rpdf command to read pdfs
:command! -complete=file -nargs=1 Rpdf :r !pdftotext -nopgbrk <q-args> -

call plug#begin('~/.config/nvim/plugged')
	Plug 'da-h/AirLatex.vim', {'do': ':UpdateRemotePlugins'}
	Plug 'lervag/vimtex', {'for': 'tex'}
	Plug 'godlygeek/tabular'
	Plug 'plasticboy/vim-markdown', {'for': 'markdown'}
	Plug 'KeitaNakamura/tex-conceal.vim', {'for': 'tex'}
	Plug 'SirVer/ultisnips'
	Plug 'quangnguyen30192/cmp-nvim-ultisnips'
	Plug 'honza/vim-snippets'
	Plug 'tpope/vim-surround'
	Plug 'rakr/vim-one'
	Plug 'Th3Whit3Wolf/one-nvim'
	Plug 'cespare/vim-toml', { 'branch': 'main' }
	Plug 'lifepillar/vim-solarized8'
	Plug 'kaicataldo/material.vim'
	Plug 'sjl/badwolf'
	Plug 'yonlu/omni.vim'
	Plug 'folke/tokyonight.nvim', {'branch': 'main'}
	Plug 'nickeb96/fish.vim'
	Plug 'maverickg/stan.vim', {'for': 'stan'}
	" Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins', 'for': 'python'}
	" Plug 'davidhalter/jedi-vim'
	" Plug 'ncm2/ncm2', {'for': 'python'}
	" Plug 'roxma/nvim-yarp'
	" Plug 'ncm2/ncm2-jedi'
	" Words in buffer completion
	" Plug 'ncm2/ncm2-bufword'
	" Filepath completion
	" Plug 'ncm2/ncm2-path'
	Plug 'mrtazz/simplenote.vim'
	Plug 'iamcco/markdown-preview.nvim', {'do': { -> mkdp#util#install()}, 'for': ['markdown', '', 'vim-plug']}
	Plug 'dpelle/vim-LanguageTool'
	" Haskell
	Plug 'neovimhaskell/haskell-vim'
	Plug 'jeetsukumaran/vim-python-indent-black'
	" To save with sudo priviliges
	Plug 'lambdalisue/suda.vim'
	Plug 'taketwo/vim-ros'
	Plug 'vimplug/nvim-colorizer.lua'
	Plug 'neovim/nvim-lspconfig'
	Plug 'hrsh7th/cmp-nvim-lsp'
	Plug 'hrsh7th/cmp-buffer'
	Plug 'hrsh7th/cmp-path'
	Plug 'hrsh7th/cmp-cmdline'
	Plug 'hrsh7th/nvim-cmp'
	Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
	Plug 'kyazdani42/nvim-web-devicons'
	Plug 'kyazdani42/nvim-tree.lua'
    Plug 'p00f/nvim-ts-rainbow'
	Plug 'lewis6991/gitsigns.nvim'
call plug#end()

lua require'colorizer'.setup()

set completeopt=menu,menuone,noselect,noinsert
set shortmess+=c
inoremap <c-c> <ESC>

lua <<EOF
  -- Setup nvim-cmp.
  local cmp = require'cmp'

  cmp.setup({
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
        vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
      end,
    },
    window = {
      -- completion = cmp.config.window.bordered(),
      -- documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      -- { name = 'vsnip' }, -- For vsnip users.
      -- { name = 'luasnip' }, -- For luasnip users.
      { name = 'ultisnips' }, -- For ultisnips users.
      -- { name = 'snippy' }, -- For snippy users.
    }, {
      { name = 'buffer' },
    })
  })
  -- Mappings.
  -- See `:help vim.diagnostic.*` for documentation on any of the below
  local opts = { noremap=true, silent=true }
  vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
  vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
  vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
  vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

  -- Use an on_attach function to only map the following keys
  -- after the language server attaches to the current buffer
  local on_attach = function(client, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local bufopts = { noremap=true, silent=true, buffer=bufnr }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
    vim.keymap.set('n', '<space>wl', function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, bufopts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
    vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
    vim.keymap.set('n', '<space>f', vim.lsp.buf.formatting, bufopts)
  end

  -- Set configuration for specific filetype.
  cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
      { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
    }, {
      { name = 'buffer' },
    })
  })

  -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline('/', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' }
    }
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    })
  })

  -- Setup lspconfig.
  local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
  -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
  require('lspconfig')['pylsp'].setup {
    capabilities = capabilities,
    on_attach = on_attach,
    flags = lsp_flags,
  }
  require('lspconfig')['vimls'].setup {
	  capabilities=capabilities,
      on_attach = on_attach,
	  flags = lsp_flags,
  }
  require('lspconfig')['clangd'].setup {
	  capabilities=capabilities,
      on_attach = on_attach,
	  flags = lsp_flags,
  }

  -- TreeSitter config
  require'nvim-treesitter.configs'.setup {
    -- A directory to install the parsers into.
    -- If this is excluded or nil parsers are installed
    -- to either the package dir, or the "site" dir.
    -- If a custom path is used (not nil) it must be added to the runtimepath.

    -- A list of parser names, or "all"
    ensure_installed = "all",

    -- Install parsers synchronously (only applied to `ensure_installed`)
    sync_install = false,

    -- Automatically install missing parsers when entering buffer
    auto_install = false,

    -- List of parsers to ignore installing (for "all")
     ignore_install = { "" },

    highlight = {
      -- `false` will disable the whole extension
      enable = true,

      -- list of language that will be disabled
      -- disable = { "c", "rust" },

      -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
      -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
      -- Using this option may slow down your editor, and you may see some duplicate highlights.
      -- Instead of true it can also be a list of languages
      additional_vim_regex_highlighting = false,
    },
    rainbow = {
        enable = true,
        extended_mode = true,
        max_file_lines = nil,
    }
  }
  vim.opt.runtimepath:append("")
  require("nvim-tree").setup()
  require('gitsigns').setup {
    signs = {
  	add          = {hl = 'GitSignsAdd'   , text = '│', numhl='GitSignsAddNr'   , linehl='GitSignsAddLn'},
  	change       = {hl = 'GitSignsChange', text = '│', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
  	delete       = {hl = 'GitSignsDelete', text = '_', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
  	topdelete    = {hl = 'GitSignsDelete', text = '‾', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
  	changedelete = {hl = 'GitSignsChange', text = '~', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
    },
    signcolumn = true,  -- Toggle with `:Gitsigns toggle_signs`
    numhl      = false, -- Toggle with `:Gitsigns toggle_numhl`
    linehl     = false, -- Toggle with `:Gitsigns toggle_linehl`
    word_diff  = false, -- Toggle with `:Gitsigns toggle_word_diff`
    watch_gitdir = {
  	interval = 1000,
  	follow_files = true
    },
    attach_to_untracked = true,
    current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
    current_line_blame_opts = {
  	virt_text = true,
  	virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
  	delay = 1000,
  	ignore_whitespace = false,
    },
    current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
    sign_priority = 6,
    update_debounce = 100,
    status_formatter = nil, -- Use default
    max_file_length = 40000, -- Disable if file is longer than this (in lines)
    preview_config = {
  	-- Options passed to nvim_open_win
  	border = 'single',
  	style = 'minimal',
  	relative = 'cursor',
  	row = 0,
  	col = 1
    },
    yadm = {
  	enable = false
    },
  }
EOF

au Filetype vim set
			\ tabstop=4
			\ softtabstop=4
			\ shiftwidth=4
			\ autoindent
			\ smarttab

au Filetype toml set
			\ tabstop=4
			\ softtabstop=4
			\ shiftwidth=4
			\ expandtab
			\ autoindent
			\ smarttab
			\ fileformat=unix

au Filetype xml set
			\ tabstop=2
			\ softtabstop=2
			\ shiftwidth=2
			\ expandtab
			\ autoindent
			\ smarttab
			\ fileformat=unix

" .py
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

" let g:pyindent_open_paren = '&sw'
" let g:pyindent_continue = '&sw'

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

" .fish
au Filetype fish set
			\ tabstop=2
			\ softtabstop=2
			\ shiftwidth=2
			\ autoindent
			\ expandtab
			\ smarttab
			\ fileformat=unix

" .tex
au Filetype tex set
			\ tabstop=4
			\ softtabstop=4
			\ shiftwidth=4
			\ autoindent
			\ conceallevel=2
            \ expandtab
            \ smarttab
            \ fileformat=unix

let g:vimtex_enable=1
let g:vimtex_quickfix_mode=0
let g:tex_flavor='latex'
let g:tex_conceal='abdmg'
hi conceal guibg=gray12 guifg=orange

let g:netrw_liststyle=3


au Filetype markdown set conceallevel=2
let g:vim_markdown_folding_disabled=1

let g:UltisnipsExpandTrigger = '<tab>'


let g:languagetool_jar = '$HOME/LanguageTool-4.9.1/languagetool-commandline.jar'

colorscheme one-nvim

" Movement commands
nnoremap j gj
nnoremap k gk
nnoremap gv `[v`]
nnoremap Y y$

nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>

nnoremap <space> za

abbrev teh the
