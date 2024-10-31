local M = {}
local ids = {}

function M.single_vertical()
  vim.cmd('vsplit')
end

local function init(k)
  ids[k] = vim.api.nvim_get_current_win()
end

function M.setup()
  vim.cmd('rightbelow vsplit')
  vim.cmd('wincmd l')
  init("diff")
  vim.cmd('wincmd h')
  vim.cmd('rightbelow split')
  vim.cmd('wincmd j')
  init("status")
  vim.cmd('wincmd l')
  vim.cmd('rightbelow split')
  vim.cmd('wincmd j')
  init("filelist")
  return ids
end

return M
