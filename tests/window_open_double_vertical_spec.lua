describe('window.open', function()
  local window_open = require('super-commit.window.open')
  it('should increase 2 buffers and windows', function()
    local ini_buf_num = #vim.api.nvim_list_bufs()
    local ini_win_num = #vim.api.nvim_list_wins()

    window_open.setup()

    local new_buf_num = #vim.api.nvim_list_bufs()
    local new_win_num = #vim.api.nvim_list_wins()

    assert.are.equal(ini_buf_num + 2, new_buf_num)
    assert.are.equal(ini_win_num + 2, new_win_num)
  end)
end)
