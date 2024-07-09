require "toggleterm".setup {
    size = 20,
    open_mapping = [[<C-\>]],
    shade_terminals = true,
    shading_factor = 2,
    start_in_insert = true,
    insert_mappings = true,
    persist_size = true,
    direction = "float",
    close_on_exit = true,
    shell = "/usr/bin/fish",
    float_opts = {
        border = "curved",
    },
}
