local window_open = require('super-commit/window/open')
local git_cmds = require('super-commit/git/commands')
local map_table = git_cmds.map_table

local M = {}
local git_keys = {"status", "filelist", "diff"}

function M.init()
  window_open.setup()
  for _, k in pairs(git_keys) do
    if map_table[k].bufid then
      git_cmds.show_init_cmd(k)
    end
  end
end

function M.autocmd_callback()
  M.init()
  vim.api.nvim_set_keymap(
      'n',
      '<CR>',
      '<Cmd>lua require("super-commit/git/commands")' ..
      '.show_selected_diff()<CR>',
      { noremap = true, silent = true }
  )
  vim.api.nvim_set_keymap(
      'n',
      '<C-h>',
      '<Cmd>lua require("super-commit.window.float").help()<CR>',
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
