local M = {}
M.init_commands = {"status", "filelist", "diff"}

M.map_table = {}
M.map_table["status"] = {winnum=nil, bufnum=nil, command="git status"}
M.map_table["filelist"] = {winnum=nil, bufnum=nil,
                          command="git diff --name-only --cached"}
local file_select_suggestion = "To show git diff of files, " ..
                            "select the file path shown above, " ..
                            "and press Enter."
M.map_table["diff"] = {winnum=nil, bufnum=nil,
                      command="echo " .. file_select_suggestion}

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

function M.show_selected_diff()
    M.show_diff(
      M.map_table["diff"].bufnum,
      vim.api.nvim_get_current_line()
    )
end

return M
