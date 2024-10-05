local M = {}

function M.single_vertical()
  vim.cmd('vsplit')
  vim.cmd('enew')
end

function M.double_vertical()
  vim.cmd('rightbelow vsplit')
  vim.cmd('wincmd l')
  vim.cmd('enew')
  vim.cmd('wincmd h')
  vim.cmd('rightbelow split')
  vim.cmd('wincmd j')
  vim.cmd('enew')
end

return M
