local function bootstrap_pckr()
    local pckr_path = vim.fn.stdpath("data") .. "/pckr/pckr.nvim"

    if not vim.loop.fs_stat(pckr_path) then
        vim.fn.system({
            'git',
            'clone',
            "--filter=blob:none",
            'https://github.com/lewis6991/pckr.nvim',
            pckr_path
        })
    end

    vim.opt.rtp:prepend(pckr_path)
end

bootstrap_pckr()

-- local cmd = require('pckr.loader.cmd')
-- local keys = require('pckr.loader.keys')

return require("pckr").add {
    "wbthomason/packer.nvim",
    "LintaoAmons/scratch.nvim",
    'gsuuon/note.nvim',
    "stevearc/oil.nvim",
    { "bluz71/vim-nightfly-guicolors", as = "nightfly" },
    {
        'uloco/bluloco.nvim',
        requires = { 'rktjmp/lush.nvim' }
    },
    -- 'kuznetsss/meadow.nvim',
    '~/meadow.nvim',
    'folke/tokyonight.nvim',
    -- -- Fuzzy Finder (files, lsp, etc)
    { 'nvim-telescope/telescope.nvim', branch = '0.1.x', requires = { { 'nvim-lua/plenary.nvim' } } },

    -- -- Fuzzy Finder Algorithm which requires local dependencies to be built.
    -- -- Only load if `make` is available. Make sure you have the system
    -- -- requirements installed.
    {
        'nvim-telescope/telescope-fzf-native.nvim',
        -- NOTE: If you are having trouble with this installation,
        --       refer to the README for telescope-fzf-native for more instructions.
        run = "make",
    },

    -- Treesitter and other HL plugins
    {
        -- Highlight, edit, and navigate code
        'nvim-treesitter/nvim-treesitter',
        run = ":TSUpdate"
    },
    {
        "nvim-treesitter/nvim-treesitter-textobjects",
        -- after = "nvim-treesitter",
        requires = "nvim-treesitter/nvim-treesitter",
    },
    -- { "nvim-treesitter/playground",  };
    "HiPhish/rainbow-delimiters.nvim",
    "lukas-reineke/indent-blankline.nvim",

    "kyazdani42/nvim-web-devicons",

    -- Text editing tools
    { 'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup()
        end
    },
    {
        "kylechui/nvim-surround",
        config = function()
            require("nvim-surround").setup {}
        end
    },
    'windwp/nvim-autopairs',

    -- Undotree
    "mbbill/undotree",

    -- Git
    "tpope/vim-fugitive",
    "lewis6991/gitsigns.nvim",

    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v2.x',
        requires = {
            -- LSP Support
            { 'neovim/nvim-lspconfig' },             -- Required
            { 'williamboman/mason.nvim' },           -- Optional
            { 'williamboman/mason-lspconfig.nvim' }, -- Optional

            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },     -- Required
            { 'hrsh7th/cmp-nvim-lsp' }, -- Required
            { 'L3MON4D3/LuaSnip' },     -- Required
            { 'saadparwaiz1/cmp_luasnip' },
            { 'rafamadriz/friendly-snippets' }
        }
    },


    -- Suda
    { "lambdalisue/suda.vim" },

    -- Toggleterm
    "akinsho/toggleterm.nvim",

    -- Nvim-tree
    "nvim-tree/nvim-tree.lua",

    -- Lualine
    {
        'nvim-lualine/lualine.nvim',
        requires = { 'nvim-tree/nvim-web-devicons', opt = true }
    },

    -- Haskell stuffs
    {
        'mrcjkb/haskell-tools.nvim',
        requires = {
            'nvim-lua/plenary.nvim',
            'nvim-telescope/telescope.nvim',                 -- optional
        },
        commit = '217cb7958ebbebf360f7c43efd5129e66d748042', -- recommended
    },

    -- Markdown stuffs
    "ixru/nvim-markdown",

    -- Squirrel, jump between treesitter nodes
    { "xiaoshihou514/squirrel.nvim" },
    "danymat/neogen",
}
