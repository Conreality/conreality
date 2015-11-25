(* This is free and unencumbered software released into the public domain. *)

open Prelude

class driver = object (self)
  inherit Device.driver as super

  method is_privileged = true

  method driver_name = "bcm2835"

  method device_name = "bcm2835"
end

type t = driver
