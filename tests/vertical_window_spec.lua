describe('window.vertical_window', function()
  local vertical_window = require('super-commit.window.vertical_window')
  it('should increase buffer and window number', function()
    local ini_buf_num = #vim.api.nvim_list_bufs()
    local ini_win_num = #vim.api.nvim_list_wins()

    vertical_window.open()

    local new_buf_num = #vim.api.nvim_list_bufs()
    local new_win_num = #vim.api.nvim_list_wins()

    assert.are.equal(ini_buf_num + 1, new_buf_num)
    assert.are.equal(ini_win_num + 1, new_win_num)
  end)
end)
