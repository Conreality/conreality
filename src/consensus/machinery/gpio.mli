(* This is free and unencumbered software released into the public domain. *)

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
  class virtual driver : int -> object
    method id : unit -> int
  end
  type t = driver
end

(* Device driver interface for GPIO pins. *)
module Pin : sig
  class virtual driver : int -> object
    method id : unit -> int
    method virtual mode : unit -> Mode.t
    method virtual set_mode : Mode.t -> unit
    method virtual read : unit -> bool
    method virtual write : bool -> unit
  end
  type t = driver
end
