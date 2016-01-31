(* This is free and unencumbered software released into the public domain. *)

#if OCAMLVERSION < 4020
type bytes = string
#endif

(* Device driver interface for cameras. *)
module Camera : sig
  class virtual ['a] interface : object
    inherit ['a] Device.interface
    (* Device interface: *)
    method reset : unit
    method parent : 'a Device.t option
    method is_privileged : bool
    method virtual driver_name : string
    method virtual device_name : string
    method device_path : string list
    (* Camera interface: *)
    method virtual init :unit
    method virtual close : unit
  end
  type 'a t = 'a interface
end

module GPIO : sig
  (* Variant for selecting GPIO input/output modes. *)
  module Mode : sig
    type t = Input | Output
    val of_string : string -> t
    val to_string : t -> string
    val of_bytes : bytes -> t
    val to_bytes : t -> bytes
    val to_flags : t -> Unix.open_flag list
  end

  (* Device driver interface for GPIO chips. *)
  module Chip : sig
    class virtual ['a] interface : int -> object
      inherit ['a] Device.interface
      (* Device interface: *)
      method reset : unit
      method parent : 'a Device.t option
      method is_privileged : bool
      method driver_name : string
      method device_name : string
      method device_path : string list
      (* GPIO.Chip interface: *)
      method id : int
    end
    type 'a t = 'a interface
  end

  (* Device driver interface for GPIO pins. *)
  module Pin : sig
    class virtual ['a] interface : int -> object
      inherit ['a] Device.interface
      (* Device interface: *)
      method reset : unit
      method parent : 'a Device.t option
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
    type 'a t = 'a interface
  end
end

(* Device driver interface for PWM control. *)
module PWM : sig
  class virtual ['a] interface : int -> object
    inherit ['a] Device.interface
    (* Device interface: *)
    method reset : unit
    method parent : 'a Device.t option
    method is_privileged : bool
    method virtual driver_name : string
    method virtual device_name : string
    method device_path : string list
    (* PWM interface: *)
    method id : int
    method is_open : bool
    method virtual is_closed : bool
    method virtual init : GPIO.Mode.t -> unit (* FIXME: take config from Lua *)
    method virtual close : unit
    method virtual mode : GPIO.Mode.t
    method virtual read : bool                (* FIXME: add PWM-specific parameters *)
    method virtual write : bool -> unit       (* FIXME: add PWM-specific parameters *)
  end
  type 'a t = 'a interface
end
