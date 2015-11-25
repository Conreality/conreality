(* This is free and unencumbered software released into the public domain. *)

class driver : object
  method reset : unit
  method parent : Device.t option
  method is_privileged : bool
  method driver_name : string
  method device_name : string
  method device_path : string list
end

type t = driver
