local plenary_path = os.getenv("plenary_path") or "/tmp/plenary.nvim"
local is_not_a_directory = vim.fn.isdirectory(plenary_path) == 0
if is_not_a_directory then
  vim.fn.system(
    {"git", "clone", "https://github.com/nvim-lua/plenary.nvim", plenary_path}
  )
end

vim.opt.rtp:append('.')
vim.opt.rtp:append(plenary_path)

vim.cmd("runtime plugin/plenary.vim")
require("plenary.busted")
