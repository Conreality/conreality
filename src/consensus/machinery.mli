(* This is free and unencumbered software released into the public domain. *)

(* Driver interfaces for GPIO chips and pins. *)
module GPIO : sig
  [%%include "machinery/gpio.mli"]
end

(* Driver implementation for the Broadcom BCM2835 SoC (e.g., Raspberry Pi 1). *)
module BCM2835 : sig
  [%%include "machinery/bcm2835.mli"]
end

(* Driver implementation for the Broadcom BCM2836 SoC (e.g., Raspberry Pi 2). *)
module BCM2836 : sig
  [%%include "machinery/bcm2836.mli"]
end

(* Driver implementation for GPIO pins via the Linux sysfs VFS interface. *)
(* See: https://www.kernel.org/doc/Documentation/gpio/ *)
module Sysfs : sig
  [%%include "machinery/sysfs.mli"]
end
