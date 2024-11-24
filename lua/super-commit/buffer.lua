local M = {}
local bufids = {}

function M.getid(git_key)
  return bufids[git_key]
end

local filetype = {}
filetype["commit"] = "gitcommit"
filetype["status"] = "gitrebase"
filetype["diff"] = "git"

function M.setup(git_key)
  bufids[git_key] = vim.api.nvim_create_buf(false, true)
  if (filetype[git_key]) then
    vim.api.nvim_set_option_value("filetype", filetype[git_key], {buf = bufids[git_key]})
  end
end

return M
