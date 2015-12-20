(* This is free and unencumbered software released into the public domain. *)

module Protocol : sig
  val port : int
end

module Command : sig
  type t =
    | Enable of string
    | Disable of string
    | Toggle of string
  val to_string : t -> string
  val length : t -> int
end

module Client : sig
  type t
end

module Server : sig
  type t
end
