local status_ok, lsp_installer = pcall(require, "nvim-lsp-installer")
if not status_ok then
	return
end

local servers = {
    "pylsp",
    "sumneko_lua",
    "clangd",
}

lsp_installer.setup({
    ensure_installed = servers,
})

local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
    return
end

local opts = {}

for _, server in pairs(servers) do
    opts = {
        on_attach = require("user.lsp.handlers").on_attach,
        capabilities = require("user.lsp.handlers").capabilities,
    }
    if server == "sumneko_lua" then
        local sumneko_opts = require "user.lsp.settings.sumneko_lua"
        opts = vim.tbl_deep_extend("force", sumneko_opts, opts)
    end

    if server == "pylsp" then
        local pylsp_opts = require "user.lsp.settings.pylsp"
        opts = vim.tbl_deep_extend("force", pylsp_opts, opts)
    end

    lspconfig[server].setup(opts)
end