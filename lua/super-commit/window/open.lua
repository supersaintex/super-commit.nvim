local M = {}
local winids = {}

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

local function split_by_ratio(k, ratio, is_above_split)
  ratio = ratio or 0.5
  local split = 'below'
  if is_above_split then
    split = 'above'
  end
  winids[k] = vim.api.nvim_open_win(0, true, {
    split=split,
    win=0,
    height = math.floor(vim.api.nvim_win_get_height(0)*ratio),
  })

  if split == 'below' then
    vim.cmd('wincmd k')
  else
    vim.cmd('wincmd j')
  end
end

local function vsplit_by_ratio(k, ratio, is_left_split)
  ratio = ratio or 0.5
  local split = 'right'
  if is_left_split then
    split = 'left'
  end
  winids[k] = vim.api.nvim_open_win(0, true, {
    split=split,
    win=0,
    width = math.floor(vim.api.nvim_win_get_width(0)*ratio),
  })

  if split == 'right' then
    vim.cmd('wincmd h')
  else
    vim.cmd('wincmd l')
  end
end

local function open_2x2()
  winids[layout_2x2[1][1]] = vim.api.nvim_get_current_win()
  split_by_ratio(layout_2x2[2][1], 0.6)
  vsplit_by_ratio(layout_2x2[1][2], 0.5)
  vim.cmd('wincmd j')
  vsplit_by_ratio(layout_2x2[2][2], 0.5)
  vim.api.nvim_win_set_cursor(0, {1, 0})
end

local function open_3x1()
  winids[layout_3x1[1][1]] = vim.api.nvim_get_current_win()
  split_by_ratio(layout_2x2[2][1], 0.6)
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

function M.getid(k)
  return winids[k]
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

local float_config = {}

float_config["help"] ={
  width = 80,
  height = 20,
  -- set ratio value to center help window almost in the screen
  vertical_pos_ratio = 0.25,
  horizontal_pos_ratio = 0.15
}

function M.float(k)
  local screen_width = vim.o.columns
  local screen_height = vim.o.lines
  local opts = {
    relative = "editor",
    width = float_config[k].width,
    height = float_config[k].height,
    col = screen_width * float_config[k].horizontal_pos_ratio,
    row = screen_height * float_config[k].vertical_pos_ratio,
    anchor = "NW",
    style = "minimal",
    border = "rounded"
  }
  winids[k] = vim.api.nvim_open_win(0, true, opts)
end

return M
