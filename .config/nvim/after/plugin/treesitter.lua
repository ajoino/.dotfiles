require 'nvim-treesitter.configs'.setup {
    ensure_installed = "all",

    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
    indent = { enable = true, },
    textobjects = {
        select = {
            enable = true,
            lookahead = true,
            keymaps = {
                ["af"] = "@function.outer",
                ["if"] = "@function.inner",
                ["ac"] = "@class.outer",
                ["ic"] = "@class.inner",
                ["ab"] = "@block.outer",
                ["ib"] = "@block.inner",
            }
        }
    },
}


require "nvim-autopairs".setup()
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
local cmp = require('cmp')
cmp.event:on(
    'confirm_done',
    cmp_autopairs.on_confirm_done()
)

require "neogen".setup { snippet_engine = "luasnip" }
require "squirrel"

require "rainbow-delimiters"

vim.g.rainbow_delimiters = {
    query = {
        [""] = "rainbow-delimiters",
        lua = "rainbow-blocks",
    },
}
