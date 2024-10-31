local M = {}
local init_commands = {}
init_commands["status"] = "git status"
init_commands["filelist"] = "git diff --name-only --cached"
local file_select_suggestion = "To show git diff of files, " ..
                            "select the file path in the window below, " ..
                            "and press Enter."
init_commands["diff"] = "echo " .. file_select_suggestion

function M.show_init(k)
  local bufids = require('super-commit/super-commit').bufids
  local output_str =  vim.fn.system(init_commands[k])
  local output_table = vim.split(output_str, '\n')
  vim.api.nvim_buf_set_lines(bufids[k], 0, -1, false, output_table)
end

function M.show_output(bufid, command)
  local output_str =  vim.fn.system(command)
  local output_table = vim.split(output_str, '\n')
  vim.api.nvim_buf_set_lines(bufid, 0, -1, false, output_table)
end

function M.show_diff(bufid, rel_path)
  local git_root = vim.fn.systemlist("git rev-parse --show-toplevel")[1]
  local abs_path = git_root .. "/" .. rel_path
  M.show_output(bufid, "git diff --cached ".. abs_path)
end

function M.show_selected_diff()
  local bufids = require('super-commit/super-commit').bufids
  M.show_diff(
    bufids["diff"],
    vim.api.nvim_get_current_line()
  )
end

return M
