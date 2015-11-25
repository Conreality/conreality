(* This is free and unencumbered software released into the public domain. *)

class virtual driver : object
  (* Resets the device, if applicable. *)
  method reset : unit -> unit

  (* Returns the parent device, if any. *)
  method parent : unit -> driver option

  (* Determines whether the driver requires superuser privileges. *)
  method is_privileged : unit -> bool

  (* Returns the machine-readable name of the driver. *)
  method virtual driver_name : unit -> string

  (* Returns the machine-readable name of the device. *)
  method virtual device_name : unit -> string

  (* Returns the machine-readable path of the device. *)
  method device_path : unit -> string list
end

type t = driver
