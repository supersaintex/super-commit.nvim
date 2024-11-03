local M = {}
local ids = {}

function M.single_vertical()
  vim.cmd('vsplit')
end

function M.setup()
  local win_cmds = {
    diff = {
      "rightbelow vsplit",
      "wincmd l",
    },
    status = {
      "wincmd h",
      "rightbelow split",
      "wincmd j",
    },
    filelist = {
      "wincmd l",
      "rightbelow split",
      "wincmd j",
    },
  }
  local function init(key)
    for _,v in pairs(win_cmds[key]) do
      vim.cmd(v)
    end
    ids[key] = vim.api.nvim_get_current_win()
  end
  init("diff")
  init("status")
  init("filelist")
  return ids
end

return M
