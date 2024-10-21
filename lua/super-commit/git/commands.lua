local M = {}

M.win_manage_table = {}
M.win_manage_table["test-win"] = {win_num=nil, buf_num=nil, command = nil}
-- M.win_manage_table["commit-msg"] = {win_num=nil, buf_num=nil}
M.win_manage_table["git-status"] = {win_num=nil, buf_num=nil, command="git status"}
M.win_manage_table["filelist"] = {win_num=nil, buf_num=nil, command="git diff --name-only --cached"}
local git_diff_init_msg = "echo 'To show git diff of files, select the file path in the window below, and press Enter.'"
M.win_manage_table["git-diff-init"] = {win_num=nil, buf_num=nil, command=git_diff_init_msg}

function M.show_command_output(bufnum, command)
  local output_str =  vim.fn.system(command)
  local output_table = vim.split(output_str, '\n')
  vim.api.nvim_buf_set_lines(bufnum, 0, -1, false, output_table)
end

function M.show_command_output_v2(gitcmd)
  local output_str =  vim.fn.system(gitcmd.command)
  local output_table = vim.split(output_str, '\n')
  vim.api.nvim_buf_set_lines(gitcmd.buf_num, 0, -1, false, output_table)
end

function M.show_diff_cmd_output(bufnum, path)
  M.show_command_output(bufnum, "git diff --cached ".. path)
end

return M
