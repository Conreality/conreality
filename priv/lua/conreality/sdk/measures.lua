-- This is free and unencumbered software released into the public domain.

--- Measures & quantities.
-- @module conreality.sdk.measures
local measures = {
  Quantity = {},
}

measures.length = {}
measures.mass = {}
measures.time = {}
measures.current = {}
measures.temperature  = {}

--- Lengths.
-- TODO
-- @section length

--- Micrometers (1/1000000 of a meter).
-- @tparam number magnitude
function measures.length.um(magnitude)
  return Quantity.new(measures.length, magnitude, -6)
end
measures['μm'] = measures.um

--- Millimeters (1/1000 of a meter).
-- @tparam number magnitude
function measures.length.mm(magnitude)
  return Quantity.new(measures.length, magnitude, -3)
end

--- Centimeters (1/100 of a meter).
-- @tparam number magnitude
function measures.length.cm(magnitude)
  return Quantity.new(measures.length, magnitude, -2)
end

--- Decimeters (1/10 of a meter).
-- @tparam number magnitude
function measures.length.dm(magnitude)
  return Quantity.new(measures.length, magnitude, -1)
end

--- Meters.
-- @tparam number magnitude
function measures.length.m(magnitude)
  return Quantity.new(measures.length, magnitude, 0)
end

--- Decameters (10 meters).
-- @tparam number magnitude
function measures.length.dkm(magnitude)
  return Quantity.new(measures.length, magnitude, 1)
end

--- Hectometers (100 meters).
-- @tparam number magnitude
function measures.length.hm(magnitude)
  return Quantity.new(measures.length, magnitude, 2)
end

--- Kilometers (1,000 meters).
-- @tparam number magnitude
function measures.length.km(magnitude)
  return Quantity.new(measures.length, magnitude, 3)
end

--- Mass.
-- TODO
-- @section mass

--- Time.
-- TODO
-- @section time

--- Current.
-- TODO
-- @section current

--- Temperature.
-- TODO
-- @section temperature

--- Quantity class metatable.
-- @type Quantity
local Quantity = measures.Quantity

--- The dimension (e.g., measures.length).
Quantity.dimension = nil

--- The magnitude (a floating-point number).
Quantity.magnitude = 0.

--- The scale (-12 to 12).
Quantity.scale = 0

--- Constructs a new quantity.
-- @tparam table dimension
-- @tparam number magnitude
-- @tparam number scale
-- @treturn Quantity
function Quantity.new(dimension, magnitude, scale)
  local self = {
    dimension = dimension,
    magnitude = magnitude or Quantity.magnitude,
    scale     = scale or Quantity.scale,
  }
  setmetatable(self, {__index = Quantity})
  return self
end

return measures
