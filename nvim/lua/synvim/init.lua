local M = {}

local state_mod = require("synvim.state")
local ui = require("synvim.ui")

M.state = state_mod.state
M.ui = ui

function M.setup()
  -- Track active working directory across terminal and editor splits
  vim.api.nvim_create_autocmd({ "BufEnter", "WinEnter", "TermOpen" }, {
    callback = function(args)
      local buf = args.buf
      if not vim.api.nvim_buf_is_valid(buf) then return end
      local bt = vim.bo[buf].buftype
      if bt == "terminal" then
        local cwd = ui.get_terminal_cwd(buf)
        if cwd then
          M.state.last_terminal_cwd = cwd
          M.state.last_terminal_buf = buf
          M.state.last_terminal_win = vim.api.nvim_get_current_win()
          M.state.latest_focus_cwd = cwd
          M.state.latest_focus_type = "terminal"
        end
      elseif bt == "" then
        local name = vim.api.nvim_buf_get_name(buf)
        if name ~= "" and not name:match("^%a+://") and vim.fn.filereadable(name) == 1 then
          local dir = vim.fs.root(name, { ".git", "Cargo.toml", "Makefile", "pyproject.toml" }) or vim.fn.fnamemodify(name, ":p:h")
          if dir and dir ~= vim.fn.expand("~") and dir ~= "/" then
            M.state.latest_focus_cwd = dir
            M.state.latest_focus_type = "editor"
          end
        end
      end
    end,
    desc = "Track active directory across terminal and editor splits",
  })

  -- Help command (:Synvim)
  vim.api.nvim_create_user_command("Synvim", function(_)
    ui.show_help()
  end, {
    nargs = "?",
    complete = function(arglead, _)
      return vim.tbl_filter(function(s) return vim.startswith(s:lower(), arglead:lower()) end, { "help" })
    end,
    desc = "Show synvim commands and usage (:Synvim help)",
  })
end

return M
