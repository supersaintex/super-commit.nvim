local M = {}

function M.single_vertical()
  vim.cmd('vsplit')
  vim.cmd('enew')
end

function M.setup()
  local bufnum_1 = vim.api.nvim_get_current_buf();
  vim.cmd('rightbelow vsplit')
  vim.cmd('wincmd l')
  vim.cmd('enew')
  local bufnum_2 = vim.api.nvim_get_current_buf();
  vim.cmd('wincmd h')
  vim.cmd('rightbelow split')
  vim.cmd('wincmd j')
  vim.cmd('enew')
  local bufnum_3 = vim.api.nvim_get_current_buf();

  local bufnum_table = {bufnum_1, bufnum_2, bufnum_3}
  return bufnum_table
end

return M
