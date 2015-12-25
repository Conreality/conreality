(* This is free and unencumbered software released into the public domain. *)

type t = int
val of_float : float -> int
val of_string : string -> int
val to_string : int -> string
val compare : t -> t -> int
