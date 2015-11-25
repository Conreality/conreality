(* This is free and unencumbered software released into the public domain. *)

class driver : object
  method reset : unit -> unit
  method parent : unit -> Device.t option
  method is_privileged : unit -> bool
  method driver_name : unit -> string
  method device_name : unit -> string
  method device_path : unit -> string list
end

type t = driver
