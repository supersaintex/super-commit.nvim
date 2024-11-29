local config = require('super-commit/config/user-config')

local M = {}

function M.debug(valnm, value)
  if config.get("debug") then
    if type(value) == "table" then
      print("[DEBUG] " .. valnm)
      for k, v in pairs(value) do
        print ("key: " .. k .. "  value: " .. v)
      end
    else
      print("[DEBUG] ".. valnm .. ":" .. value .. "\n")
    end
  end
end

return M
