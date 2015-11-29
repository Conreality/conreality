(* This is free and unencumbered software released into the public domain. *)

module Device = struct
  [%%include "machinery/device.ml"]
end

module Abstract = struct
  [%%include "machinery/abstract.ml"]
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

module USB = struct
  [%%include "machinery/usb.ml"]
end

(* Note: this must remain the last module in this file. *)
module Driver = struct
  [%%include "machinery/driver.ml"]
end
