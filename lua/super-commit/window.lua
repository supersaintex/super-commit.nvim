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
      local bufnum_table = window_open.setup()
      local commands = git_cmds.commands
      for k, cmd in pairs(commands) do
          git_cmds.show_command_output(bufnum_table[k], cmd)
      end
    end,
  })
end

function M.setup()
  M.set_autocmd()
end

return M
