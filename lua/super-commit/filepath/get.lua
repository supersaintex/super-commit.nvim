local M = {}

function M.cursor_no()
    local cursor_position = vim.api.nvim_win_get_cursor(0)
    local current_line = cursor_position[1]

    return current_line
end

function M.get()
   local bufnumber = vim.api.nvim_get_current_buf()
   local cursol_line_no = M.cursor_no();
   local paths = vim.api.nvim_buf_get_lines(bufnumber,
       cursol_line_no - 1,
       cursol_line_no,
       false)
   local path = paths[1]
   print(path)
   return path
end

return M
