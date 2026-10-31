local M = {}

--- Find scribe executable
function M.get_scribe_bin()
    local bin = vim.fn.exepath("scribe")
    if bin ~= "" then return bin end

    local user_local = vim.fn.expand("~/.local/bin/scribe")
    if vim.fn.executable(user_local) == 1 then return user_local end

    local repo_bin = vim.fn.expand("~/code/scribe/bin/scribe")
    if vim.fn.executable(repo_bin) == 1 then return repo_bin end

    return nil
end

--- Record speech and insert transcription into the active buffer at the cursor
function M.dictate_into_buffer()
    local scribe_bin = M.get_scribe_bin()
    if not scribe_bin then
        vim.notify("Scribe CLI not found. Install or link to ~/.local/bin/scribe", vim.log.levels.ERROR)
        return
    end

    local cur_buf = vim.api.nvim_get_current_buf()
    local cur_win = vim.api.nvim_get_current_win()
    local row, col = unpack(vim.api.nvim_win_get_cursor(cur_win))

    -- Open a small popup terminal window running scribe
    local width = math.min(65, vim.o.columns - 4)
    local height = 4
    local r = math.floor((vim.o.lines - height) / 2)
    local c = math.floor((vim.o.columns - width) / 2)

    local term_buf = vim.api.nvim_create_buf(false, true)
    local term_win = vim.api.nvim_open_win(term_buf, true, {
        relative = "editor",
        width = width,
        height = height,
        row = r,
        col = c,
        style = "minimal",
        border = "single",
        title = " Scribe Voice Input ",
        title_pos = "center",
    })

    local out_file = vim.fn.tempname()
    local cmd = string.format("%s -q > %s", vim.fn.shellescape(scribe_bin), vim.fn.shellescape(out_file))

    vim.fn.termopen(cmd, {
        on_exit = function(_, exit_code)
            if vim.api.nvim_win_is_valid(term_win) then
                vim.api.nvim_win_close(term_win, true)
            end
            if vim.api.nvim_buf_is_valid(term_buf) then
                vim.api.nvim_buf_delete(term_buf, { force = true })
            end

            if exit_code == 0 and vim.fn.filereadable(out_file) == 1 then
                local lines = vim.fn.readfile(out_file)
                local text = vim.trim(table.concat(lines, " "))
                if text ~= "" and vim.api.nvim_buf_is_valid(cur_buf) then
                    local line = vim.api.nvim_buf_get_lines(cur_buf, row - 1, row, false)[1] or ""
                    local before = line:sub(1, col)
                    local after = line:sub(col + 1)
                    local sep = (before ~= "" and not before:match("%s$")) and " " or ""
                    local new_line = before .. sep .. text .. after
                    vim.api.nvim_buf_set_lines(cur_buf, row - 1, row, false, { new_line })
                    vim.api.nvim_win_set_cursor(cur_win, { row, col + #sep + #text })
                    vim.notify("✓ Scribe: inserted text", vim.log.levels.INFO)
                end
            end
            pcall(vim.fn.delete, out_file)
        end,
    })

    vim.cmd("startinsert")
end

function M.setup()
    vim.api.nvim_create_user_command("Listen", function()
        M.dictate_into_buffer()
    end, { desc = "Voice dictation into buffer via Scribe CLI (:Listen)" })

    vim.keymap.set("n", "<leader>v", function()
        M.dictate_into_buffer()
    end, { desc = "Voice dictation via Scribe (:Listen)" })
end

return M
