(* This is free and unencumbered software released into the public domain. *)

open Prelude

module Video_device = struct
  class virtual driver (id : string) = object (self)
    inherit Device.driver as super

    method driver_name = "usb.video"
  end

  type t = driver
end

module Camera = struct
  class driver (id : string) = object (self)
    inherit Video_device.driver id as super

    method driver_name = "usb.camera"

    method device_name = Printf.sprintf "usb/camera/%s" id
  end

  type t = driver
end
