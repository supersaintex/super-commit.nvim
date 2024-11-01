local git_cmds = require('super-commit/git/commands')
local map_table = git_cmds.map_table
local init_commands = git_cmds.init_commands

local M = {}

local function set_current_number(k)
  map_table[k].bufnum =  vim.api.nvim_get_current_buf();
  map_table[k].winnum =  vim.api.nvim_win_get_number(0);
end

function M.setup()
  vim.cmd('rightbelow vsplit')
  vim.cmd('wincmd l')
  vim.cmd('enew')
  set_current_number(init_commands[2])
  vim.cmd('wincmd h')
  vim.cmd('rightbelow split')
  vim.cmd('wincmd j')
  vim.cmd('enew')
  set_current_number(init_commands[1])
  vim.cmd('wincmd l')
  vim.cmd('rightbelow split')
  vim.cmd('wincmd j')
  vim.cmd('enew')
  set_current_number(init_commands[3])

end

return M
