(* This is free and unencumbered software released into the public domain. *)

module Device = struct
  [%%include "machinery/device.ml"]
end

module GPIO = struct
  [%%include "machinery/gpio.ml"]
end

module BCM2835 = struct
  [%%include "machinery/bcm2835.ml"]
end

module BCM2836 = struct
  [%%include "machinery/bcm2836.ml"]
end

module Sysfs = struct
  [%%include "machinery/sysfs.ml"]
end
