local api = require "nvim-tree.api"
local function my_on_attach(bufnr)

    local function opts(desc)
        return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
    end

    api.config.mappings.default_on_attach(bufnr)

end
require("nvim-tree").setup {
    hijack_netrw = true,
    update_focused_file = {
        enable = true,
        update_cwd = true,
    },
    view = { width = 30, side = "left" },
    filters = { dotfiles = true },
    diagnostics = {
        enable = true,
        show_on_dirs = true,
        icons = {
            hint = "H",
            info = "I",
            warning = "W",
            error = "E",
        }
    },
    renderer = {
        indent_markers = {
            enable = true
        },
    },
    on_attach = my_on_attach,
}

require("oil").setup()
