local M = {}

function M.show_command_output(bufnum, command)
  local output_str =  vim.fn.system(command)
  local output_table = vim.split(output_str, '\n')
  vim.api.nvim_buf_set_lines(bufnum, 0, -1, false, output_table)
end

function M.show_diff_cmd_output(bufnum, path)
  M.show_command_output(bufnum, "git diff --cached ".. path)
end

local commands = {}
commands[2] = "echo select a file under window"
commands[3] = "git status"
commands[4] = "git diff --name-only --cached"

M.commands = commands

return M
