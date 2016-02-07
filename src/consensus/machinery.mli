(* This is free and unencumbered software released into the public domain. *)

(** Machine drivers. *)

(** Read/write access to physical memory. *)
module RAM : sig
  #include "machinery/ram.mli"
end

(** Driver interfaces for abstract devices. *)
module rec Abstract : sig
  #include "machinery/abstract.mli"
end

(** Driver interfaces common to all devices. *)
and Device : sig
  #include "machinery/device.mli"
end

(** Driver implementation for the Broadcom BCM2835 SoC (e.g., Raspberry Pi 1). *)
module BCM2835 : sig
  #include "machinery/bcm2835.mli"
end

(** Driver implementation for the Broadcom BCM2836 SoC (e.g., Raspberry Pi 2). *)
module BCM2836 : sig
  #include "machinery/bcm2836.mli"
end

(** Driver implementation for GPIO pins via the Linux sysfs VFS interface. *)
(* See: https://www.kernel.org/doc/Documentation/gpio/ *)
module Sysfs : sig
  #include "machinery/sysfs.mli"
end

(** Driver implementations for various USB device classes. *)
(* See: https://en.wikipedia.org/wiki/USB#Device_classes *)
module USB : sig
  #include "machinery/usb.mli"
end

(** Driver implementations for V4L2 devices. *)
(* See: http://linuxtv.org/downloads/v4l-dvb-apis/ *)
module V4L2 : sig
  #include "machinery/v4l2.mli"
end

(** Driver metadata interfaces. *)
(* Note: this must remain the last module in this file. *)
module Driver : sig
  #include "machinery/driver.mli"
end
