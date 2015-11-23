(* This is free and unencumbered software released into the public domain. *)

external code : char -> int = "%identity"
val chr : int -> char
val escaped : char -> string
val lowercase : char -> char
val uppercase : char -> char
type t = char
val compare : t -> t -> int
external unsafe_chr : int -> char = "%identity"
val of_string : string -> char
val to_string : char -> string
val compare : t -> t -> int
