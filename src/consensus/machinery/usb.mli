(* This is free and unencumbered software released into the public domain. *)

(* See: https://en.wikipedia.org/wiki/Universal_serial_bus#Device_classes *)
module Device_class : sig
  type t = Unknown | Video
  val of_int : int -> t
  val to_int : t -> int
end

(* Device driver interface for USB devices. *)
(* See: https://en.wikipedia.org/wiki/Universal_serial_bus#Device_classes *)
module Generic_device : sig
  class virtual interface : string -> object
    inherit Device.interface
    (* Device interface: *)
    method reset : unit
    method parent : Device.t option
    method is_privileged : bool
    method driver_name : string
    method virtual device_name : string
    method device_path : string list
    (* USB.Generic_device interface: *)
    method class_id : Device_class.t
    method virtual vendor_id : int
    method virtual product_id : int
    method id : int * int
  end
  type t = interface
end

(* Device driver interface for USB video class (UVC) devices. *)
(* See: https://en.wikipedia.org/wiki/USB_video_device_class *)
module Video_device : sig
  class virtual interface : string -> object
    inherit Generic_device.interface
    (* Device interface: *)
    method reset : unit
    method parent : Device.t option
    method is_privileged : bool
    method driver_name : string
    method virtual device_name : string
    method device_path : string list
    (* USB.Generic_device interface: *)
    method class_id : Device_class.t
    method virtual vendor_id : int
    method virtual product_id : int
    method id : int * int
    (* USB.Video_device interface: *)
  end
  type t = interface
end

(* Device driver implementation for USB cameras. *)
(* See: https://en.wikipedia.org/wiki/List_of_USB_video_class_devices *)
module Camera : sig
  class implementation : string -> object
    inherit Video_device.interface
    (* Device interface: *)
    method reset : unit
    method parent : Device.t option
    method is_privileged : bool
    method driver_name : string
    method device_name : string
    method device_path : string list
    (* USB.Generic_device interface: *)
    method class_id : Device_class.t
    method vendor_id : int
    method product_id : int
    method id : int * int
    (* USB.Video_device interface: *)
  end
  type t = implementation
end
