local git_cmds = require('super-commit/git/commands')
local win_manage_table = git_cmds.win_manage_table

local M = {}

function M.single_vertical()
  vim.cmd('vsplit')
  vim.cmd('enew')
end


function M.setup()
  win_manage_table["test-win"].buf_num =  vim.api.nvim_get_current_buf();
  win_manage_table["test-win"].win_num =  vim.api.nvim_win_get_number(0);
  vim.cmd('rightbelow vsplit')
  vim.cmd('wincmd l')
  vim.cmd('enew')
  win_manage_table["git-diff-init"].buf_num =  vim.api.nvim_get_current_buf();
  win_manage_table["git-diff-init"].win_num =  vim.api.nvim_win_get_number(0);
  vim.cmd('wincmd h')
  vim.cmd('rightbelow split')
  vim.cmd('wincmd j')
  vim.cmd('enew')
  win_manage_table["git-status"].buf_num =  vim.api.nvim_get_current_buf();
  win_manage_table["git-status"].win_num =  vim.api.nvim_win_get_number(0);
  vim.cmd('wincmd l')
  vim.cmd('rightbelow split')
  vim.cmd('wincmd j')
  vim.cmd('enew')
  win_manage_table["filelist"].buf_num =  vim.api.nvim_get_current_buf();
  win_manage_table["filelist"].win_num =  vim.api.nvim_win_get_number(0);

end

return M
