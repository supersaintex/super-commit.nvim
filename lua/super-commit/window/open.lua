local buf_num = require('super-commit/buffer/open').number

local M = {}

function M.single_vertical()
  vim.cmd('vsplit')
  vim.cmd('enew')
end

local function set_current_number(k)
  buf_num[k] =  vim.api.nvim_get_current_buf();
end

function M.setup()
  vim.cmd('rightbelow vsplit')
  vim.cmd('wincmd l')
  vim.cmd('enew')
  set_current_number("diff")
  vim.cmd('wincmd h')
  vim.cmd('rightbelow split')
  vim.cmd('wincmd j')
  vim.cmd('enew')
  set_current_number("status")
  vim.cmd('wincmd l')
  vim.cmd('rightbelow split')
  vim.cmd('wincmd j')
  vim.cmd('enew')
  set_current_number("filelist")

end

return M
