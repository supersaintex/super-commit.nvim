local M = {}

function M.open()
  vim.cmd('vsplit')
  vim.cmd('enew')
end

return M
