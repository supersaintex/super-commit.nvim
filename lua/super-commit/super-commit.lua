local window_open = require('super-commit/window/open')
local git_cmds = require('super-commit/git/commands')
local win_manage_table = git_cmds.win_manage_table

local M = {}

function M.show_selected_diff()
    git_cmds.show_diff_cmd_output(
        win_manage_table["git-diff-init"].buf_num,
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
      git_cmds.show_command_output_v2(win_manage_table["git-status"])
      git_cmds.show_command_output_v2(win_manage_table["filelist"])
      git_cmds.show_command_output_v2(win_manage_table["git-diff-init"])
      vim.api.nvim_set_keymap(
          'n',
          '<CR>',
          [[<Cmd>lua require('super-commit/super-commit').show_selected_diff()<CR>]],
          { noremap = true, silent = true }
	)
    end,
  })
end

function M.setup()
  M.set_autocmd()
end

return M
