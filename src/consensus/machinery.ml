(* This is free and unencumbered software released into the public domain. *)

module rec Abstract : sig
  #include "machinery/abstract.mli"
end = struct
  #include "machinery/abstract.ml"
end

and Device : sig
  #include "machinery/device.mli"
end = struct
  #include "machinery/device.ml"
end

module BCM2835 = struct
  #include "machinery/bcm2835.ml"
end

module BCM2836 = struct
  #include "machinery/bcm2836.ml"
end

module Sysfs = struct
  #include "machinery/sysfs.ml"
end

module USB = struct
  #include "machinery/usb.ml"
end

module V4L2 = struct
  #include "machinery/v4l2.ml"
end

(* Note: this must remain the last module in this file. *)
module Driver = struct
  #include "machinery/driver.ml"
end
