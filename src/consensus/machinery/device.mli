(* This is free and unencumbered software released into the public domain. *)

class virtual driver : object
  (* Resets the device, if applicable. *)
  method reset : unit

  (* Returns the parent device, if any. *)
  method parent : driver option

  (* Determines whether the driver requires superuser privileges. *)
  method is_privileged : bool

  (* Returns the machine-readable name of the driver. *)
  method virtual driver_name : string

  (* Returns the machine-readable name of the device. *)
  method virtual device_name : string

  (* Returns the machine-readable path of the device. *)
  method device_path : string list
end

type t = driver
