vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- Allows you to move selected text
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "Y", "yg$")
vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Greatest remap ever
vim.keymap.set("x", "<leader>p", [["_dP]])

-- Next greatest remap eve : asbjornHaland
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set("n", "Q", "<nop>")

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- Move between visible buffers
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-l>", "<C-w>l")
--
-- Stay in indent mode
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- Telescope related keymaps
local telescope = require "telescope.builtin"
vim.keymap.set("n", "<leader>pf", telescope.find_files, {})
vim.keymap.set("n", "<C-p>", telescope.git_files, {})
vim.keymap.set("n", "<leader>ps", function()
    telescope.grep_string({ search = vim.fn.input("Grep > "), use_regex = true })
end)
vim.keymap.set("n", "<leader>nc", function()
    telescope.find_files({ cwd = "~/.config/nvim/", search_dirs = { "lua/", "after/", "init.lua", } })
end)
vim.keymap.set('n', '<leader>pr', telescope.lsp_references, { noremap = true, silent = true })

local nvim_tree_api = require "nvim-tree.api"
vim.keymap.set("n", "<leader>e", nvim_tree_api.tree.toggle)
