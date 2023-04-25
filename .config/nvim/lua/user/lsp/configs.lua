local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
    return
end
local status_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
if not status_ok then
	return
end
local mason_null_status_ok, mason_null_ls = pcall(require, "mason-null-ls")
if not mason_null_status_ok then
    return
end

local servers = {
    "pylsp",
    "lua_ls",
    "clangd",
    "dockerls",
}

local opts = {
    on_attach = require("user.lsp.handlers").on_attach,
    capabilities = require("user.lsp.handlers").capabilities,
}

mason_lspconfig.setup {
    ensure_installed = servers
}
mason_lspconfig.setup_handlers {
    function (server)
        local server_ok, server_opts = pcall(require, "user.lsp.settings." .. server)
        if not server_ok then
            lspconfig[server].setup (opts)
        else
            lspconfig[server].setup (vim.tbl_deep_extend("force", server_opts, opts))
        end
    end
}
mason_null_ls.setup {
    ensure_installed = {"hadolint"}
}


--[=[
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
