vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.opt.nu = true
vim.opt.relativenumber = true
vim.opt.numberwidth = 4

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")
vim.opt.cursorline = true

vim.opt.updatetime = 50

vim.opt.splitbelow = true
vim.opt.splitright = true

vim.g.python3_host_prog = "/home/jacob/.config/nvim/venv3.11/bin/python3.11"
vim.g.python_recommended_style = 0
