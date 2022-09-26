local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = fn.system {
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path
    }
    print "Installing packer. Close and reopen Neovim..."
    vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
    augroup packer_user_config
        autocmd!
        autocmd BufWritePost plugins.lua source <afile> | PackerSync
    augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
    return
end

-- Have packer use a pop-up window
packer.init {
    display = {
        open_fn = function()
            return require("packer.util").float { border = "rounded" }
        end,
    },
}

-- Insert plugins here
return packer.startup(function(use)
    use "wbthomason/packer.nvim" -- Have packer manage itself
    use "nvim-lua/popup.nvim" -- Popup api from vim
    use "nvim-lua/plenary.nvim" -- Useful lua functions used by plugins
    use "windwp/nvim-autopairs"
    use { "numToStr/Comment.nvim", commit = "2c26a00f32b190390b664e56e32fd5347613b9e2" }
    use 'JoosepAlviste/nvim-ts-context-commentstring'
    use "kyazdani42/nvim-web-devicons"
    use "kyazdani42/nvim-tree.lua"
    use "akinsho/toggleterm.nvim"
    use "lukas-reineke/indent-blankline.nvim"
    use 'lambdalisue/suda.vim'
    use {
        "kylechui/nvim-surround",
        tag = "*",
        config = function ()
            require("nvim-surround").setup({})
        end
    }
    use {
        'iamcco/markdown-preview.nvim',
        run = function() vim.fn["mkpd#util#install"]() end,
    }

    -- Colorschemes
    use "lunarvim/darkplus.nvim"
    use "yonlu/omni.vim"
    use "marko-cerovac/material.nvim"
    use "bluz71/vim-nightfly-guicolors"

    -- cmp plugins
    use "hrsh7th/nvim-cmp" -- The completion plugin
    use "hrsh7th/cmp-buffer" -- buffer completions
    use "hrsh7th/cmp-path" -- path completions
    use "saadparwaiz1/cmp_luasnip" -- snippet completions
    use "hrsh7th/cmp-nvim-lsp" -- cmdline completions
    use "hrsh7th/cmp-nvim-lua" -- cmdline completions

    -- snippets
    use "L3MON4D3/LuaSnip" --snippet engine
    use "rafamadriz/friendly-snippets" -- a bunch of snippets to use

    -- LSP
    use "williamboman/mason.nvim"
    use "neovim/nvim-lspconfig" -- enable LSP
    use "williamboman/mason-lspconfig.nvim"
    use "WhoIsSethDaniel/mason-tool-installer.nvim"
    use "RRethy/vim-illuminate" -- Illuminate other uses of current word/symbol under cursor

    -- Telescope
    use "nvim-telescope/telescope.nvim"
    use "nvim-telescope/telescope-media-files.nvim"

    -- Treesitter
    use {
        "nvim-treesitter/nvim-treesitter",
        run = ":TSUpdate",
    }
    use "p00f/nvim-ts-rainbow"

    -- Git
    use "lewis6991/gitsigns.nvim"

    -- DAP
      use { "mfussenegger/nvim-dap", commit = "014ebd53612cfd42ac8c131e6cec7c194572f21d" }
      use { "rcarriga/nvim-dap-ui", commit = "d76d6594374fb54abf2d94d6a320f3fd6e9bb2f7" }
      use { "ravenxrz/DAPInstall.nvim", commit = "8798b4c36d33723e7bba6ed6e2c202f84bb300de" }

    -- Automatically set up your configuration after cloning packer.nvim
    -- Goes after all plugins
    if PACKER_BOOTSTRAP then
        require("packer").sync()
    end
end)
