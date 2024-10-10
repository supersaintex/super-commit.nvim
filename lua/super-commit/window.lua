local window_open = require('super-commit/window/open')
local git_cmds = require('super-commit/git/commands')

local M = {}

function M.set_autocmd()
  M.augroup = vim.api.nvim_create_augroup('SuperCommitWindow', {})
  vim.api.nvim_create_autocmd({'BufNewFile', 'BufRead'}, {
    group = M.augroup,
    pattern = '*.super',
    -- pattern = 'COMMIT_EDITMSG',
    callback = function()
      window_open.double_vertical()
      local status_num = 3
      local diff_num = 2
      git_cmds.show_git_status(status_num)
      git_cmds.show_git_diff(diff_num)
    end,
  })
end

function M.setup()
  M.set_autocmd()
end

return M
