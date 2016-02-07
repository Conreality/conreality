(* This is free and unencumbered software released into the public domain. *)

external code : char -> int = "%identity"
val chr : int -> char
val escaped : char -> string
val lowercase : char -> char
val uppercase : char -> char
type t = char
val compare : t -> t -> int
external unsafe_chr : int -> char = "%identity"

val zero : char
val of_int : int -> char
val to_int : char -> int
val of_int32 : int32 -> char
val to_int32 : char -> int32
val of_int64 : int64 -> char
val to_int64 : char -> int64
val of_string : string -> char
val to_string : char -> string
val compare : t -> t -> int
