-- This is free and unencumbered software released into the public domain.

--- Hardware interface
-- @module conreality.sdk.machinery
local machinery = {
  Camera  = {},
  Gamepad = {},
}

--- Camera class metatable
-- @type Camera
local Camera = machinery.Camera

--- The camera's unique identifier.
Camera.id = nil

--- The camera's descriptive label.
Camera.label = nil

--- Gamepad class metatable
-- @type Gamepad
local Gamepad = machinery.Gamepad

--- The gamepad's unique identifier.
Gamepad.id = nil

--- The gamepad's descriptive label.
Gamepad.label = nil

return machinery
