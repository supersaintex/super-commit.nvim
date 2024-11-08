local M = {}

M.map_table = {}
M.map_table["status"] = {winid=nil, bufid=nil}
M.map_table["filelist"] = {winid=nil, bufid=nil}
M.map_table["diff"] = {winid=nil, bufid=nil}

local init_cmds = {}
init_cmds["status"] = "git status"
init_cmds["filelist"] = "git diff --name-only --cached"
local file_select_suggestion = "To show git diff of files, " ..
                            "select the file path shown above, " ..
                            "and press Enter."
init_cmds["diff"] = "echo " .. file_select_suggestion

function M.show_output(bufid, cmd)
  local output_str =  vim.fn.system(cmd)
  local output_table = vim.split(output_str, '\n')
  vim.api.nvim_buf_set_lines(bufid, 0, -1, false, output_table)
end

function M.show_init_cmd(k)
  M.show_output(M.map_table[k].bufid, init_cmds[k])
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
