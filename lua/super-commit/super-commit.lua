local window_open = require('super-commit/window/open')

local git_cmds = require('super-commit/git/commands')
local init_commands = git_cmds.init_commands
local map_table = git_cmds.map_table

local M = {}

function M.init()
  window_open.setup()
  for _, k in pairs(init_commands) do
    git_cmds.show_output(map_table[k].bufnum, map_table[k].command)
  end
end

function M.show_selected_diff()
    git_cmds.show_diff(
        map_table["diff"].bufnum,
        vim.api.nvim_get_current_line()
    )
end

function M.autocmd_callback()
  M.init()
  vim.api.nvim_set_keymap(
      'n',
      '<CR>',
      '<Cmd>lua require("super-commit/super-commit")' ..
      '.show_selected_diff()<CR>',
      { noremap = true, silent = true }
  )
end

function M.set_autocmd()
  M.augroup = vim.api.nvim_create_augroup('SuperCommitWindow', {})
  vim.api.nvim_create_autocmd({'BufNewFile', 'BufRead'}, {
    group = M.augroup,
    pattern = '*.super',
    -- pattern = 'COMMIT_EDITMSG',
    callback = M.autocmd_callback,
  })
end

function M.setup()
  M.set_autocmd()
end

return M
