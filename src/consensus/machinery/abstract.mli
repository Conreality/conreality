(* This is free and unencumbered software released into the public domain. *)

(* Device driver interface for cameras. *)
module Camera : sig
  class virtual interface : object
    inherit Device.interface
    (* Device interface: *)
    method reset : unit
    method parent : Device.t option
    method is_privileged : bool
    method virtual driver_name : string
    method virtual device_name : string
    method device_path : string list
    (* Camera interface: *)
    method virtual init :unit
    method virtual close : unit
  end
  type t = interface
end

module GPIO : sig
  (* Variant for selecting GPIO input/output modes. *)
  module Mode : sig
    type t = Input | Output
    val of_string : string -> t
    val to_string : t -> string
    val of_bytes : bytes -> t
    val to_bytes : t -> bytes
  end

  (* Device driver interface for GPIO chips. *)
  module Chip : sig
    class virtual interface : int -> object
      inherit Device.interface
      (* Device interface: *)
      method reset : unit
      method parent : Device.t option
      method is_privileged : bool
      method driver_name : string
      method device_name : string
      method device_path : string list
      (* GPIO.Chip interface: *)
      method id : int
    end
    type t = interface
  end

  (* Device driver interface for GPIO pins. *)
  module Pin : sig
    class virtual interface : int -> object
      inherit Device.interface
      (* Device interface: *)
      method reset : unit
      method parent : Device.t option
      method is_privileged : bool
      method driver_name : string
      method device_name : string
      method device_path : string list
      (* GPIO.Pin interface: *)
      method id : int
      method is_open : bool
      method virtual is_closed : bool
      method virtual init : Mode.t -> unit
      method virtual close : unit
      method virtual mode : Mode.t
      method virtual read : bool
      method virtual write : bool -> unit
    end
    type t = interface
  end
end
