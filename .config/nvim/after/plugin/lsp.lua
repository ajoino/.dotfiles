local lsp = require('lsp-zero').preset({})

-- lsp.on_attach(function(client, bufnr)
--   -- see :help lsp-zero-keybindings
--   -- to learn the available actions
--   lsp.default_keymaps({buffer = bufnr})
-- end)

-- (Optional) Configure lua language server for neovim
require("mason-lspconfig").setup {
	ensure_installed = {
		"lua_ls",
		"pylsp",
		"ruff_lsp",
		"marksman",
		"clangd",
		"html",
		"sqlls",
		"lemminx",
		"groovyls",
		"dockerls",
		"bashls",
		"cmake",
		"jsonls",
        "taplo",
	},
}

require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())
require("lspconfig").pylsp.setup {
	settings = {
		pylsp = {
			plugins = {
				autopep8 = { enabled = false },
				black = { enabled = true },
				pylsp_mypy = { enabled = true },
				rope_autoimport = { enabled = true },
				rope_completion = { enabled = true },
				isort = { enabled = true },
				mccabe = { enabled = false },
				pycodestyle = { enabled = false },
				pydocstyle = { enabled = false },
				pyflakes = { enabled = false },
				flake8 = { enabled = false },
			},
		},
	},
}
require "lspconfig".ruff_lsp.setup {
	on_attach = function(client, bufnr)
		client.server_capabilities.documentFormattingProvider = false
	end }

require "lspconfig".marksman.setup {}
require "lspconfig".clangd.setup {}
require "lspconfig".html.setup {}
require 'lspconfig'.sqlls.setup {}
require 'lspconfig'.lemminx.setup {}
require "lspconfig".groovyls.setup {}
require "lspconfig".bashls.setup {}
require "lspconfig".nginx_language_server.setup {}
require "lspconfig".cmake.setup {}
require "lspconfig".jsonls.setup {}
require "lspconfig".taplo.setup {}

require "lspconfig".dockerls.setup {
	on_attach = function(client, bufnr)
		vim.api.nvim_set_hl(0, '@lsp.type.parameter.dockerfile', {})
	end
}


-- Luasnip config
local luasnip = require("luasnip")
vim.keymap.set({ "i" }, "<C-K>", function() luasnip.expand() end, { silent = true })
vim.keymap.set({ "i", "s" }, "<C-L>", function() luasnip.jump(1) end, { silent = true })
vim.keymap.set({ "i", "s" }, "<C-J>", function() luasnip.jump(-1) end, { silent = true })

vim.keymap.set({ "i", "s" }, "<C-E>", function()
	if luasnip.choice_active() then
		luasnip.change_choice(1)
	end
end, { silent = true })
require('luasnip.loaders.from_vscode').lazy_load()
luasnip.config.setup {}

-- nvim-cmp config
local cmp = require("cmp")
cmp.setup {
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end
	},
	sources = {
		{ name = "nvim_lsp", max_item_count = 10 },
		{ name = "luasnip",  max_item_count = 5 },
		{ name = "path",     max_item_count = 5 },
		{ name = "buffer",   keyword_length = 5 },
	},
}

local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = lsp.defaults.cmp_mappings({
	["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
	["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
	["<C-y>"] = cmp.mapping.confirm({
		select = true,
		behavior = cmp.ConfirmBehavior.Insert,
	}),
	["<C-e>"] = cmp.mapping.close(),
	["<C-space>"] = cmp.mapping.complete(),
})


lsp.set_preferences {
	sign_icons = {}
}

lsp.setup_nvim_cmp {
	mapping = cmp_mappings
}

-- lsp.on_attach(function(client, bufnr)
--     local opts = { buffer = bufnr, remap = false }
--     lsp.default_keymaps({ buffer = bufnr })
--     vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
--     vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
--     vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
--     vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
--     vim.keymap.set("n", "]d", function() vim.diagnostic.goto_next() end, opts)
--     vim.keymap.set("n", "[d", function() vim.diagnostic.goto_prev() end, opts)
--     vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
--     vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
--     vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
--     vim.keymap.set("n", "<leader>vrf", function() vim.lsp.buf.format({ async = true }) end, opts)
--     vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
-- end
-- )
vim.api.nvim_create_autocmd('LspAttach', {
	group = vim.api.nvim_create_augroup('UserLspConfig', {}),
	callback = function(ev)
		vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"
		local opts = { buffer = ev.buf, remap = false }
		lsp.default_keymaps({ buffer = bufnr })
		vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
		vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
		vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
		vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
		vim.keymap.set("n", "]d", function() vim.diagnostic.goto_next() end, opts)
		vim.keymap.set("n", "[d", function() vim.diagnostic.goto_prev() end, opts)
		vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
		vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
		vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
		vim.keymap.set("n", "<leader>vrf", function() vim.lsp.buf.format({ async = true }) end, opts)
		vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
	end
})

lsp.setup()

vim.diagnostic.config({ float = { source = true } })
