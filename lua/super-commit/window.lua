local window_open = require('super-commit/window/open')

local M = {}

function M.set_autocmd()
  M.augroup = vim.api.nvim_create_augroup('SuperCommitWindow', {})
  vim.api.nvim_create_autocmd({'BufNewFile', 'BufRead'}, {
    group = M.augroup,
    pattern = '*.txt',
    -- pattern = 'COMMIT_EDITMSG',
    callback = function()
      window_open.double_vertical()
    end,
  })
end

function M.setup()
  M.set_autocmd()
end

return M
