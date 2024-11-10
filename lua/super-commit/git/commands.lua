local M = {}

local init_cmds = {}
init_cmds["status"] = "git status"
init_cmds["filelist"] = "git diff --name-only --cached"
local file_select_suggestion = "To show git diff of files, " ..
                            "select the file path shown above, " ..
                            "and press Enter."
init_cmds["diff"] = "echo " .. file_select_suggestion

function M.get_output(cmd)
  local output_str =  vim.fn.system(cmd)
  local output_table = vim.split(output_str, '\n')
  return output_table
end

function M.get_init_cmd(k)
  return M.get_output(init_cmds[k])
end

function M.get_diff(rel_path)
  local git_root = vim.fn.systemlist("git rev-parse --show-toplevel")[1]
  local abs_path = git_root .. "/" .. rel_path
  return M.get_output("git diff --cached ".. abs_path)
end


return M
