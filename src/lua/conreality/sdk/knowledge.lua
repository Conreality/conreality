-- This is free and unencumbered software released into the public domain.

--- Knowledge base.
-- @module conreality.sdk.knowledge
local kb = {
  acceleration = {},
  ambience     = {},
  armament     = {},
  comms        = {},
  equipment    = {},
  humidity     = {},
  location     = {},
  power        = {},
  pressure     = {},
  scenario     = {},
  self         = {},
  temperature  = {},
  time         = {},
  velocity     = {},
}

local measures = require('conreality.sdk.measures')

--- Returns the current acceleration as a 3-D vector.
-- @treturn Vector
function kb.acceleration.vector()
  return {0., 0., 0.} -- TODO
end

--- Determines whether the current acceleration is zero.
-- @treturn boolean
function kb.acceleration.is_zero()
  return true -- TODO
end

--- Determines whether the current acceleration is nonzero.
-- @treturn boolean
function kb.acceleration.is_nonzero()
  return not kb.acceleration.is_zero()
end

--- Determines whether the ambient environment has ample lightning.
-- @treturn boolean
function kb.ambience.is_light()
  return true  -- TODO
end

--- Determines whether the ambient environment lacks ample lightning.
-- @treturn boolean
function kb.ambience.is_dark()
  return not kb.ambience.is_light()
end

--- Determines whether the ambient environment is relatively noisy.
-- @treturn boolean
function kb.ambience.is_noisy()
  return false  -- TODO
end

--- Determines whether the ambient environment is relatively quiet.
-- @treturn boolean
function kb.ambience.is_quiet()
  return not kb.ambience.is_noisy()
end

--- Indicates whether armaments are available.
-- @treturn boolean
function kb.armament.is_armed()
  return false -- TODO
end

--- Determines the maximum precision achievable with current armament.
-- @treturn number
function kb.armament.max_precision()
  return nil -- TODO
end

--- Determines the maximum range with current armament.
-- @treturn Length
function kb.armament.max_range()
  return measures.length.m(0) -- TODO
end

--- Determines the maximum rate of fire with current armament.
-- @treturn Rate
function kb.armament.max_rate()
  return measures.rate.hz(0) -- TODO
end

--- Determines the remaining maximum number of shots with current armament.
-- @treturn number
function kb.armament.max_shots()
  return 0 -- TODO
end

--- Measures the current comms bandwidth.
-- @treturn Quantity
function kb.comms.bandwidth()
  return nil -- unknown
end

--- Measures the current comms latency.
-- @treturn Time
function kb.comms.latency()
  return nil -- unknown
end

--- Determines whether comms are currently available.
-- @treturn boolean
function kb.comms.is_available()
  return true  -- TODO
end

--- Determines whether current comms quality is good.
-- @treturn boolean
function kb.comms.is_good()
  return true  -- TODO
end

--- Determines whether current comms quality is poor.
-- @treturn boolean
function kb.comms.is_poor()
  return not kb.comms.is_good()
end

--- Determines whether comms are substantially reliable.
-- @treturn boolean
function kb.comms.is_reliable()
  return true  -- TODO
end

--- Determines whether comms are encrypted.
-- @treturn boolean
function kb.comms.is_encrypted()
  return nil -- unknown
end

--- Determines whether comms are based on radio technology.
-- @treturn boolean
function kb.comms.is_wireless()
  return true  -- TODO
end

--- Determines whether carried equipment can be disposed of should it be needed.
-- @treturn boolean
function kb.equipment.is_disposable()
  return false -- TODO
end

--- Measures the current ambient humidity.
-- @treturn number
function kb.humidity.measure()
  return nil -- unknown
end

--- Returns the latitude/longitude of the current location.
-- @treturn table
function kb.location.lat_and_long()
  return nil, nil
end

--- Returns the current location as a 3-D vector.
-- @treturn Vector
function kb.location.vector()
  return nil -- unknown
end

--- Determines whether the current location is outdoors.
-- @treturn boolean
function kb.location.is_outdoors()
  return true  -- TODO
end

--- Determines whether the current location is indoors.
-- @treturn boolean
function kb.location.is_indoors()
  return not kb.ambience.is_outdoors()
end

--- Measures the current available power.
-- @treturn number
function kb.power.measure()
  return nil -- unknown
end

--- Estimates the current rate of power consumption.
-- @treturn Quantity
function kb.power.consumption()
  return nil -- unknown
end

--- Estimates the current remaining time powered on.
-- @treturn Time
function kb.power.duration()
  return nil -- unknown
end

--- Compares the current power measurement to a reference.
-- @tparam number reference
-- @treturn boolean
function kb.power.is_lower_than(reference)
  local measurement = kb.power.measure()
  if measurement then
    return measurement < reference
  else
    return nil
  end
end

--- Compares the current power measurement to a reference.
-- @tparam number reference
-- @treturn boolean
function kb.power.is_higher_than(reference)
  local measurement = kb.power.measure()
  if measurement then
    return measurement >= reference
  else
    return nil
  end
end

--- Determines whether current available power is full (less than 20%).
-- @treturn boolean
function kb.power.is_low()
  return kb.power.is_lower_than(0.20)
end

--- Determines whether current available power is full (more than 99.9%).
-- @treturn boolean
function kb.power.is_full()
  return kb.power.is_higher_than(0.999)
end

--- Determines whether current available power is ample (more than 80%).
-- @treturn boolean
function kb.power.is_ample()
  return kb.power.is_higher_than(0.80)
end

--- Measures the current external pressure.
-- @treturn Quantity
function kb.pressure.measure()
  return nil -- unknown
end

--- Determines whether the scenario prescribes autonomous behavior.
-- @treturn boolean
function kb.scenario.is_autonomous()
  return false
end

--- Returns the node's unique object identifier.
-- @treturn number
function kb.self.id()
  return nil -- TODO
end

--- Determines the node's weight or an estimate thereof.
-- @treturn Mass
function kb.self.weight()
  return nil -- TODO
end

--- Indicates whether the node produces a significant amount of noise.
-- @treturn boolean
function kb.self.is_noisy()
  return nil -- TODO
end

--- Indicates whether the node produces an insignificant amount of noise.
-- @treturn boolean
function kb.self.is_quiet()
  return not kb.self.is_noisy()
end

--- Indicates whether the node is the last man standing in a team of one.
-- @treturn boolean
function kb.self.is_alone()
  return true  -- TODO
end

--- Indicates whether the node is currently flying.
-- @treturn boolean
function kb.self.is_flying()
  return false -- TODO
end

--- Indicates whether the node is currently on the ground.
-- @treturn boolean
function kb.self.is_grounded()
  return true  -- TODO
end

--- Indicates whether the node is currently swimming in water.
-- @treturn boolean
function kb.self.is_swimming()
  return false -- not supported at present
end

--- Indicates whether the node is currently diving underwater.
-- @treturn boolean
function kb.self.is_moving()
  return kb.velocity.is_nonzero()
end

--- Indicates whether the node is currently stationary.
-- @treturn boolean
function kb.self.is_stationary()
  return not kb.self.is_moving()
end

--- Indicates whether the node is currently accelerating.
-- @treturn boolean
function kb.self.is_accelerating()
  return kb.acceleration.is_nonzero()
end

--- Indicates whether the node is currently rotating.
-- @treturn boolean
function kb.self.is_rotating()
  return nil -- TODO
end

--- Indicates whether the node is able to move.
-- @treturn boolean
function kb.self.can_move()
  return false -- not supported at present
end

--- Indicates whether the node is able to drive on the ground.
-- @treturn boolean
function kb.self.can_drive()
  return false -- not supported at present
end

--- Indicates whether the node is able to climb obstacles.
-- @treturn boolean
function kb.self.can_climb()
  return false -- not supported at present
end

--- Indicates whether the node is able to fly in air.
-- @treturn boolean
function kb.self.can_fly()
  return false -- not supported at present
end

--- Indicates whether the node is able to swim in water.
-- @treturn boolean
function kb.self.can_swim()
  return false -- not supported at present
end

--- Indicates whether the node is able to dive underwater.
-- @treturn boolean
function kb.self.can_dive()
  return false -- not supported at present
end

--- Measures the current ambient temperature.
-- @treturn Temperature
function kb.temperature.measure()
  return nil -- unknown
end

--- Compares the current temperature measurement to a reference.
-- @tparam Temperature reference
-- @treturn boolean
function kb.temperature.is_warmer_than(reference)
  local measurement = kb.temperature.measure()
  if measurement then
    return measurement >= reference
  else
    return nil -- unknown
  end
end

--- Compares the current temperature measurement to a reference.
-- @tparam Temperature reference
-- @treturn boolean
function kb.temperature.is_colder_than(reference)
  local measurement = kb.temperature.measure()
  if measurement then
    return measurement <= reference
  else
    return nil -- unknown
  end
end

--- Determines whether the current temperature is freezing (less than 0°C).
-- @treturn boolean
function kb.temperature.is_freezing()
  return kb.temperature.is_colder_than(measures.temperature.c(0))
end

--- Determines whether the current temperature is cold (less than 10°C).
-- @treturn boolean
function kb.temperature.is_cold()
  return kb.temperature.is_colder_than(measures.temperature.c(10))
end

--- Determines whether the current temperature is warm (more than 20°C).
-- @treturn boolean
function kb.temperature.is_warm()
  return kb.temperature.is_warmer_than(measures.temperature.c(20))
end

--- Determines whether the current temperature is hot (more than 30°C).
-- @treturn boolean
function kb.temperature.is_hot()
  return kb.temperature.is_warmer_than(measures.temperature.c(30))
end

--- Determines whether the current temperature is burning hot (more than 100°C).
-- @treturn boolean
function kb.temperature.is_burning()
  return kb.temperature.is_warmer_than(measures.temperature.c(100))
end

--- Returns the current wallclock time.
-- @treturn Time
function kb.time.now()
  return nil -- TODO
end

--- Calculates the time for the local sunrise today.
-- @treturn Time
function kb.time.sunrise()
  return nil -- TODO
end

--- Calculates the time for the local sunset today.
-- @treturn Time
function kb.time.sunset()
  return nil -- TODO
end

--- Calculates the number of hours of sunlight daily.
-- @treturn number
function kb.time.hours_of_daylight()
  return nil -- TODO
end

--- Determines whether it is daytime (i.e., after sunrise, before sunset).
-- @treturn boolean
function kb.time.is_day()
  return nil -- TODO
end

--- Determines whether it is night (i.e., after sunset, before sunrise).
-- @treturn boolean
function kb.time.is_night()
  return nil -- TODO
end

--- Returns the current velocity as a 3-D vector.
-- @treturn Vector
function kb.velocity.vector()
  return {0., 0., 0.} -- TODO
end

--- Determines whether the current velocity is zero.
-- @treturn boolean
function kb.velocity.is_zero()
  return true -- TODO
end

--- Determines whether the current velocity is nonzero.
-- @treturn boolean
function kb.velocity.is_nonzero()
  return not kb.velocity.is_zero()
end

return kb
