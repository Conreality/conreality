-- This is free and unencumbered software released into the public domain.

--- World model
-- @module conreality.sdk.model
local model = {
  Object = {},
}

--- Object class metatable
-- @type Object
local Object = model.Object

--- The object's unique identifier.
Object.id = nil

--- The object's designated label.
Object.label = nil

--- The object's current position.
Object.position = nil

--- The object's current orientation.
Object.orientation = nil

--- The object's current linear velocity.
Object.linear_velocity = nil

--- The object's current angular velocity.
Object.angular_velocity = nil

--- The object's current linear acceleration.
Object.linear_acceleration = nil

--- The object's estimated mass.
Object.mass = nil

--- The object's determined shape.
Object.shape = nil

--- The object's estimated color.
Object.color = nil

--- Computes the inverse mass of this object.
-- @return quantity
function Object:inverse_mass()
  return nil -- unknown
end

--- Determines whether this object has a nonzero position.
-- @return boolean, or nil if unknown
function Object:is_located()
  return false
end

--- Determines whether this is an immovable physical object.
-- @return boolean, or nil if unknown
function Object:is_immovable()
  return nil -- unknown
end

--- Determines whether this object has a nonzero linear velocity.
-- @return boolean, or nil if unknown
function Object:is_moving()
  return nil -- unknown
end

--- Determines whether this object has a nonzero angular velocity.
-- @return boolean, or nil if unknown
function Object:is_rotating()
  return nil -- unknown
end

--- Determines whether this object has a nonzero linear acceleration.
-- @return boolean, or nil if unknown
function Object:is_accelerating()
  return nil -- unknown
end

--- Determines whether this object is currently active.
-- @return boolean, or nil if unknown
function Object:is_active()
  return nil -- unknown
end

--- Determines whether this object is currently inactive.
-- @return boolean, or nil if unknown
function Object:is_inactive()
  return nil -- unknown
end

--- Constructs a new object instance.
-- @param fields initial values for fields
-- @treturn Object
function Object.new(fields)
  local self = fields or {}
  setmetatable(self, {__index = Object})
  return self
end

return model
