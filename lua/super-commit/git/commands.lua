local M = {}

function M.show_command_output(bufnum, command)
  local output_str =  vim.fn.system(command)
  local output_table = vim.split(output_str, '\n')
  vim.api.nvim_buf_set_lines(bufnum, 0, -1, false, output_table)
end

local commands = {}
commands[3] = "git status"
commands[4] = "git diff --name-only --cached"

M.commands = commands

return M
