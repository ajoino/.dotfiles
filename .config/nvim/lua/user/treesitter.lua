local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
    return
end

configs.setup {
    ensure_istalled = "all",
    ignore_install = { "" },
    highlight = {
        enable = true,
        disable = { "" }, -- list of ignored languages
    },
    autopairs = {
        enable = true
    },
    rainbow = {
        enable = true,
        extended_mode = true,
        max_file_lines = nil,
        colors = {
            "#22AAFF",
            "#EEEE00",
            "#CCAA00",
            "#EE2222",
            "#33CC55",
        }
    },
    indent = { enable = true, disable = { "" } },
    markid = {
        enable = false,
        queries = {
            python = [[
                (import_from_statement (dotted_name) (dotted_name) @markid)
            ]]
        }
    },
    playground = {
        enable = true,
        disable = {},
        updatetime = 25, -- debounced time for highlighting nodes in the playground from source code
        persist_queries = false, -- whether the query persists across vim sessions
        keybindings = {
            toggle_query_editor = 'o',
            toggle_hl_groups = 'i',
            toggle_injected_languages = 't',
            toggle_anonymous_nodes = 'a',
            toggle_language_display = 'i',
            focus_language = 'f',
            unfocus_language = 'f',
            update = 'r',
            goto_node = '<cr>',
            show_help = '?',
        },
    }
}
