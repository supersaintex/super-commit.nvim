local git_cmds = require('super-commit/git/commands')
local map_table = git_cmds.map_table

local M = {}

local function set_current_number(k)
  map_table[k].bufid =  vim.api.nvim_get_current_buf();
  map_table[k].winid =  vim.api.nvim_win_get_number(0);
end

local layout_2x2 = {
  {'commit', 'filelist'},
  {'status', 'diff'}
}

local layout_3x1 = {
  {'commit'},
  {'filelist'},
  {'diff'},
}

local required_editor_width = 80
local required_editor_height = 20

local function split_by_ratio(init_cmd, ratio, is_above_split)
  ratio = ratio or 0.5
  local split = 'below'
  if is_above_split then
    split = 'above'
  end
  vim.api.nvim_open_win(0, true, {
    split=split,
    win=0,
    height = math.floor(vim.api.nvim_win_get_height(0)*ratio),
  })

  vim.cmd('enew')
  set_current_number(init_cmd)

  if split == 'below' then
    vim.cmd('wincmd k')
  else
    vim.cmd('wincmd j')
  end
end

local function vsplit_by_ratio(init_cmd, ratio, is_left_split)
  ratio = ratio or 0.5
  local split = 'right'
  if is_left_split then
    split = 'left'
  end
  vim.api.nvim_open_win(0, true, {
    split=split,
    win=0,
    width = math.floor(vim.api.nvim_win_get_width(0)*ratio),
  })

  vim.cmd('enew')
  set_current_number(init_cmd)

  if split == 'right' then
    vim.cmd('wincmd h')
  else
    vim.cmd('wincmd l')
  end
end

local function open_2x2()
  split_by_ratio(layout_2x2[2][1], 0.6)
  vsplit_by_ratio(layout_2x2[1][2], 0.5)
  vim.cmd('wincmd j')
  vsplit_by_ratio(layout_2x2[2][2], 0.5)
  vim.api.nvim_win_set_cursor(0, {1, 0})
end

local function open_3x1()
  split_by_ratio(layout_3x1[2][1], 0.8)
  -- ratio should be the sum of the 2nd & 3rd row
  vim.cmd('wincmd j')
  split_by_ratio(layout_3x1[3][1], 0.6)
  vim.api.nvim_win_set_cursor(0, {1, 0})
end

local function is_sufficient_width()
  local current_width = vim.api.nvim_win_get_width(0)
  if current_width < required_editor_width then
    return false
  end
  return true
end

local function is_sufficient_height()
  local current_height = vim.api.nvim_win_get_height(0)
  if current_height < required_editor_height then
    return false
  end
  return true
end

function M.setup()
  if not is_sufficient_height() then
    return
  end
  if not is_sufficient_width() then
    open_3x1()
    return
  end
  open_2x2()
end

return M
