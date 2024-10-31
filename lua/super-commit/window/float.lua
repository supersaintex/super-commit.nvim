local M = {}

function M.help()
    local buf = vim.api.nvim_create_buf(false, true)
    local messages = {
        "help of super commit",
        "",
        "Select a file from list and show git staged change."
    }
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, messages)
    local screen_width = vim.o.columns
    local screen_height = vim.o.lines
    local width = 80
    local height = 20
    local opts = {
      relative = "editor",
      width = width,
      height = height,
      col = math.floor((screen_width - width) / 2),
      row = math.floor((screen_height - height) / 2),
      anchor = "NW",
      style = "minimal",
      border = "rounded"
    }
    vim.api.nvim_open_win(buf, true, opts)
end

return M
