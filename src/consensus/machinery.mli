(* This is free and unencumbered software released into the public domain. *)

(* Driver for the Broadcom BCM2835 SoC found on the Raspberry Pi. *)
module BCM2835 : sig
  [%%include "machinery/bcm2835.mli"]
end

(* Driver for the Broadcom BCM2836 SoC found on the Raspberry Pi 2. *)
module BCM2836 : sig
  [%%include "machinery/bcm2836.mli"]
end

(* Driver for GPIO pins via the Linux sysfs VFS interface. *)
(* See: https://www.kernel.org/doc/Documentation/gpio/     *)
module GPIO : sig
  [%%include "machinery/gpio.mli"]
end
