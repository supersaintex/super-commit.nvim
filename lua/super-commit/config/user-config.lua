local M = {}

local config = {
  debug = false
}

function M.setup(conf, setting)
  config[conf] = setting
end

function M.get(conf)
  return config[conf]
end

return M
