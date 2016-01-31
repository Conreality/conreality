(* This is free and unencumbered software released into the public domain. *)

open Prelude

module Device_class = struct
  type t = Unknown | Video

  let of_int = function
    | 0x0E -> Video
    | 0x00 -> Unknown
    | _ -> assert false

  let to_int = function
    | Video   -> 0x0E
    | Unknown -> 0x00
end

module Generic_device = struct
  class virtual ['a] interface (id : string) = object (self)
    inherit ['a] Device.interface as super

    method driver_name = "usb.basic"

    method class_id = Device_class.Unknown

    method virtual vendor_id : int

    method virtual product_id : int

    method id = (self#vendor_id, self#product_id)
  end

  type 'a t = 'a interface
end

module Video_device = struct
  class virtual ['a] interface (id : string) = object (self)
    inherit ['a] Generic_device.interface id as super

    method driver_name = "usb.video"

    method class_id = Device_class.Video
  end

  type 'a t = 'a interface
end

module Camera = struct
  class ['a] implementation (id : string) = object (self)
    inherit ['a] Video_device.interface id as super

    method cast = `Camera self

    method driver_name = "usb.camera"

    method device_name = Printf.sprintf "usb/camera/%s" id

    method vendor_id = 0x0000 (* TODO *)

    method product_id = 0x0000 (* TODO *)
  end

  type 'a t = 'a implementation
end
