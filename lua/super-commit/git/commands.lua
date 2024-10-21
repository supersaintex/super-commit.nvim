local M = {}

function M.show_output(bufnum, command)
  local output_str =  vim.fn.system(command)
  local output_table = vim.split(output_str, '\n')
  vim.api.nvim_buf_set_lines(bufnum, 0, -1, false, output_table)
end

function M.show_diff(bufnum, rel_path)
  local git_root = vim.fn.systemlist("git rev-parse --show-toplevel")[1]
  local abs_path = git_root .. "/" .. rel_path
  M.show_output(bufnum, "git diff --cached ".. abs_path)
end

local file_select_suggestion = "To show git diff of files, " ..
                            "select the file path in the window below, " ..
                            "and press Enter."

M.command_table = {}
M.command_table[2] = "echo " .. file_select_suggestion
M.command_table[3] = "git status"
M.command_table[4] = "git diff --name-only --cached"

return M
