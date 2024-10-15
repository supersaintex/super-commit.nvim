local window_open = require('super-commit/window/open')
local git_cmds = require('super-commit/git/commands')
local filepath = require('super-commit/filepath/get')

local M = {}

function M.enter_in_normalmode()
    git_cmds.show_diff_cmd_output(
        window_open.bufnums[2],
        filepath.get()
    )
end

return M
