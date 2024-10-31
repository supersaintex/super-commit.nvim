local M = {}
local ids = {}

function M.setup()
  local function init(k)
    ids[k] = vim.api.nvim_create_buf(false, true)
  end
  init("status")
  init("filelist")
  init("diff")
  return ids
end

return M
