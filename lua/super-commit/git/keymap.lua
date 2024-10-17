local window_open = require('super-commit/window/open')
local git_cmds = require('super-commit/git/commands')

local M = {}

function M.setup()
    git_cmds.show_diff_cmd_output(
        window_open.bufnum_table[2],
        vim.api.nvim_get_current_line()
    )
end

return M
