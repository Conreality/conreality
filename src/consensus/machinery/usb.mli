(* This is free and unencumbered software released into the public domain. *)

(* Device driver interface for USB video class (UVC) devices. *)
(* See: https://en.wikipedia.org/wiki/USB_video_device_class *)
module Video_device : sig
  class virtual driver : string -> object
    method reset : unit
    method parent : Device.t option
    method is_privileged : bool
    method driver_name : string
    method virtual device_name : string
    method device_path : string list
  end
  type t = driver
end

(* Device driver implementation for USB cameras. *)
(* See: https://en.wikipedia.org/wiki/List_of_USB_video_class_devices *)
module Camera : sig
  class driver : string -> object
    method reset : unit
    method parent : Device.t option
    method is_privileged : bool
    method driver_name : string
    method device_name : string
    method device_path : string list
  end
  type t = driver
end
