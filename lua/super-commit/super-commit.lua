local window_open = require('super-commit/window/open')
local git_cmds = require('super-commit/git/commands')

local M = {}

function M.show_selected_diff()
    git_cmds.show_diff(
        window_open.bufnum_table[2],
        vim.api.nvim_get_current_line()
    )
end

function M.set_autocmd()
  M.augroup = vim.api.nvim_create_augroup('SuperCommitWindow', {})
  vim.api.nvim_create_autocmd({'BufNewFile', 'BufRead'}, {
    group = M.augroup,
    pattern = '*.super',
    -- pattern = 'COMMIT_EDITMSG',
    callback = function()
      window_open.setup()
      local bufnum_table = window_open.bufnum_table
      local command_table = git_cmds.command_table
      for k, cmd in pairs(command_table) do
          git_cmds.show_output(bufnum_table[k], cmd)
      end
      vim.api.nvim_set_keymap(
          'n',
          '<CR>',
          '<Cmd>lua require("super-commit/super-commit")' ..
          '.show_selected_diff()<CR>',
          { noremap = true, silent = true }
	)
    end,
  })
end

function M.setup()
  M.set_autocmd()
end

return M
