(* This is free and unencumbered software released into the public domain. *)

module Mode : sig
  type t = Input | Output
  val of_string : string -> t
  val to_string : t -> string
  val of_bytes : bytes -> t
  val to_bytes : t -> bytes
end

module Pin : sig
  class pin : int -> object
    method id : unit -> int
    method mode : unit -> Mode.t
    method set_mode : Mode.t -> unit
    method read : unit -> bool
    method write : bool -> unit
  end
  type t = pin
  val make : int -> pin
end
