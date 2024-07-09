function Wininput(opts, on_confirm, win_opts)
    -- create a "prompt" buffer that will be deleted once focus is lost
    local buf = vim.api.nvim_create_buf(false, false)
    vim.bo[buf].buftype = "prompt"
    vim.bo[buf].bufhidden = "wipe"

    local prompt = opts.prompt or ""
    local default_text = opts.default or ""

    -- defer the on_confirm callback so that it is
    -- executed after the prompt window is closed
    local deferred_callback = function(input)
        vim.defer_fn(function()
            on_confirm(input)
        end, 10)
    end

    -- set prompt and callback (CR) for prompt buffer
    vim.fn.prompt_setprompt(buf, prompt)
    vim.fn.prompt_setcallback(buf, deferred_callback)

    -- set some keymaps: CR confirm and exit, ESC in normal mode to abort
    vim.keymap.set({ "i", "n" }, "<CR>", "<CR><Esc>:close!<CR>:stopinsert<CR>", {
        silent = true, buffer = buf
    })
    vim.keymap.set("n", "<Esc>", "<cmd>close!<CR>", {
        silent = true, buffer = buf
    })

    local default_win_opts = {
        relative = "editor",
        row = vim.o.lines / 2 - 1,
        col = vim.o.columns / 2 - 25,
        width = 50,
        height = 1,
        focusable = true,
        style = "minimal",
        border = "rounded",
    }

    win_opts = vim.tbl_deep_extend("force", default_win_opts, win_opts)

    -- adjust window width so that there is always space
    -- for prompt + default_text + a little bit
    win_opts.width = #default_text + #prompt + 5 < win_opts.width and win_opts.width or #default_text + #prompt + 5

    -- open the floating window pointing to our buffer and show the prompt
    vim.api.nvim_open_win(buf, true, win_opts)
    vim.cmd("startinsert")

    -- set the default text (needs to be deferred after prompt is drawn)
    vim.defer_fn(function()
        vim.api.nvim_buf_set_text(buf, 0, #prompt, 0, #prompt, { default_text })
        -- vim.cmd("startinsert!")
        vim.cmd("stopinsert")
        vim.api.nvim_win_set_cursor(0, { 1, #prompt + 1 })
    end, 5)
end

function BetterRename()
    local position_params = vim.lsp.util.make_position_params()
    local new_name = "hello"

    position_params.newName = new_name

    vim.lsp.buf_request(0, "textDocument/rename", position_params, function(err, result, ...)

        -- vim.lsp.handlers["textDocument/rename"](err, result)
        local entries = {}
        if result.changes then
            for uri, edits in pairs(result.changes) do
                local bufnr = vim.uri_to_bufnr(uri)
                for _, edit in ipairs(edits) do
                    local start_line = edit.range.start.line + 1
                    local line = vim.api.nvim_buf_get_lines(bufnr, start_line - 1, start_line, false)[1]
                    table.insert(entries, {
                        bufnr = bufnr,
                        lnum = start_line,
                        col = edit.range.start.character + 1,
                        text = line
                    })
                end
            end
        end

        P(entries)
        vim.fn.setqflist(entries, "r")

        vim.cmd("redraw!")
        -- TODO: Handle documentChanges?
    end)
end
