local user_config = require('super-commit/config/user-config')
user_config.setup('debug', true);
local D = require('super-commit/debug/debug').debug
local window_open = require('super-commit/window/open')
local buffer = require('super-commit/buffer')
local git_cmds = require('super-commit/git/commands')

local M = {}
local git_keys = {"status", "filelist", "diff"}
-- use case
D("git_keys", git_keys)

local function attach_output_to_win(bufid, winid, output)
  if bufid and winid and output then
    vim.api.nvim_buf_set_lines(bufid, 0, -1, false, output)
    vim.api.nvim_win_set_buf(winid, bufid)
  end
end

local function show_git(k)
  buffer.setup(k)
  local winid = window_open.getid(k)
  local bufid = buffer.getid(k)
  local output = git_cmds.get_init_cmd(k)
  attach_output_to_win(bufid, winid, output)
end

function M.init()
  window_open.setup()
  for _, k in pairs(git_keys) do
    show_git(k)
  end
end

function M.show_selected_diff()
  local bufid = buffer.getid("diff")
  local output = git_cmds.get_diff(vim.api.nvim_get_current_line())
  vim.api.nvim_buf_set_lines(bufid, 0, -1, false, output)
end

function M.show_help()
  window_open.float("help")
  buffer.setup("help")
  local bufid = buffer.getid("help")
  local winid = window_open.getid("help")
  local messages = {
      "help of super commit",
      "",
      "Select a file from list and show git staged change."
  }
  attach_output_to_win(bufid, winid, messages)
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
  vim.api.nvim_set_keymap(
      'n',
      '<C-h>',
      '<Cmd>lua require("super-commit/super-commit")' ..
      '.show_help()<CR>',
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
