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
}
