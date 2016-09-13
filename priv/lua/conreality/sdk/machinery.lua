-- This is free and unencumbered software released into the public domain.

--- Hardware interface
-- @module conreality.sdk.machinery
local machinery = {
  Gamepad = {},
}

--- Gamepad class metatable
-- @type Gamepad
local Gamepad = machinery.Gamepad

--- The gamepad's unique identifier.
Gamepad.id = nil

--- The gamepad's descriptive label.
Gamepad.label = nil

--- Constructs a new object instance.
-- @param fields initial values for fields
-- @treturn Gamepad
function Gamepad.new(fields)
  local self = fields or {}
  setmetatable(self, {__index = Gamepad})
  return self
end

return machinery
