local M = {}
local bufids = {}

function M.getid(git_key)
  return bufids[git_key]
end

function M.setup(git_key)
  bufids[git_key] = vim.api.nvim_create_buf(false, true)
end

return M
