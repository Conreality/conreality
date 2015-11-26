(* This is free and unencumbered software released into the public domain. *)

type t
val separator_string : string
val separator_char : char
val create : string list -> t
val path : t -> string list
val message_type : t -> string
val qos_policy : t -> int
val of_string : string -> t
val to_string : t -> string
