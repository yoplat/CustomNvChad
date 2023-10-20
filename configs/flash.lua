return function()
  local flash = require "flash"
  flash.setup {
    modes = {
      char = {
        keys = { "f", "F", "t", "T" },
      },
    },
  }
end
