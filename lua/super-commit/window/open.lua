local M = {}

function M.single_vertical()
  vim.cmd('vsplit')
  vim.cmd('enew')
end

M.bufnum_table ={}

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
  vim.cmd('wincmd l')
  vim.cmd('rightbelow split')
  vim.cmd('wincmd j')
  vim.cmd('enew')
  local bufnum_4 = vim.api.nvim_get_current_buf();

  M.bufnum_table = {bufnum_1, bufnum_2, bufnum_3, bufnum_4}
end

return M
