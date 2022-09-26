local mason_status_ok, mason = pcall(require, "mason")
if not mason_status_ok then
    return
end
local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
    return
end
local status_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
if not status_ok then
	return
end

local servers = {
    "pylsp",
    "sumneko_lua",
    "clangd",
    "dockerfile-language-server",
}

opts = {
    on_attach = require("user.lsp.handlers").on_attach,
    capabilities = require("user.lsp.handlers").capabilities,
}

mason.setup()
mason_lspconfig.setup {
    ensure_installed = servers
}
mason_lspconfig.setup_handlers {
    function (server)
        lspconfig[server].setup (opts)
    end
}

--[=[
for _, server in pairs(servers) do
    lspconfig[server].setup({
        on_attach = require("user.lsp.handlers").on_attach,
        capabilities = require("user.lsp.handlers").capabilities,
    })
end

local opts = {}
for _, server in pairs(servers) do
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
]=]
