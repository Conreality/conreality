(* This is free and unencumbered software released into the public domain. *)

open Prelude

class virtual interface = object (self)
  method reset = ()

  method parent = (None : interface option)

  method is_privileged = false (* a sensible default *)

  method virtual driver_name : string

  method virtual device_name : string

  method device_path =
    let device_name = [self#device_name] in
    match self#parent with
      | None -> device_name
      | Some parent -> parent#device_path @ device_name
end

type t = interface
