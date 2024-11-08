local M = {}
M.init_commands = {"status", "filelist", "diff"}

M.map_table = {}
M.map_table["status"] = {winid=nil, bufid=nil, command="git status"}
M.map_table["filelist"] = {winid=nil, bufid=nil,
                          command="git diff --name-only --cached"}
local file_select_suggestion = "To show git diff of files, " ..
                            "select the file path shown above, " ..
                            "and press Enter."
M.map_table["diff"] = {winid=nil, bufid=nil,
                      command="echo " .. file_select_suggestion}

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
    M.show_diff(
      M.map_table["diff"].bufid,
      vim.api.nvim_get_current_line()
    )
end

return M
