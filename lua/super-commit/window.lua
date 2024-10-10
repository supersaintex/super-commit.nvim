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
      local bufnum_table = window_open.double_vertical()
      git_cmds.show_git_status(bufnum_table[3])
    end,
  })
end

function M.setup()
  M.set_autocmd()
end

return M
