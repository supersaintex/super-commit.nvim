local vertical_window= require('super-commit/window/vertical_window')

local M = {}

function M.set_autocmd()
  M.augroup = vim.api.nvim_create_augroup('SuperCommitWindow', {})
  vim.api.nvim_create_autocmd({'BufNewFile', 'BufRead'}, {
    group = M.augroup,
    pattern = '*.txt',
    callback = function()
      vertical_window.open()
    end,
  })
end

function M.set_user_cmd()
  vim.api.nvim_create_user_command('OpenVerticalWindow', function()
    vertical_window.open()
  end, {})
end

function M.setup()
  M.set_autocmd()
  M.set_user_cmd()
end

return M
