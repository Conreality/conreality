(* This is free and unencumbered software released into the public domain. *)

#if OCAMLVERSION < 4020
type bytes = string
#endif

external length : bytes -> int = "%string_length"
external get : bytes -> int -> char = "%string_safe_get"
external set : bytes -> int -> char -> unit = "%string_safe_set"
external create : int -> bytes = "caml_create_string"
val make : int -> char -> bytes
#if OCAMLVERSION >= 4020
val init : int -> (int -> char) -> bytes
#endif
val empty : bytes
val copy : bytes -> bytes
val of_string : string -> bytes
val to_string : bytes -> string
val sub : bytes -> int -> int -> bytes
val sub_string : bytes -> int -> int -> string
val extend : bytes -> int -> int -> bytes
val fill : bytes -> int -> int -> char -> unit
val blit : bytes -> int -> bytes -> int -> int -> unit
val blit_string : string -> int -> bytes -> int -> int -> unit
val concat : bytes -> bytes list -> bytes
val cat : bytes -> bytes -> bytes
val iter : (char -> unit) -> bytes -> unit
val iteri : (int -> char -> unit) -> bytes -> unit
val map : (char -> char) -> bytes -> bytes
#if OCAMLVERSION >= 4020
val mapi : (int -> char -> char) -> bytes -> bytes
#endif
val trim : bytes -> bytes
val escaped : bytes -> bytes
val index : bytes -> char -> int
val rindex : bytes -> char -> int
val index_from : bytes -> int -> char -> int
val rindex_from : bytes -> int -> char -> int
val contains : bytes -> char -> bool
val contains_from : bytes -> int -> char -> bool
val rcontains_from : bytes -> int -> char -> bool
val uppercase : bytes -> bytes
val lowercase : bytes -> bytes
val capitalize : bytes -> bytes
val uncapitalize : bytes -> bytes
type t = bytes
val compare : t -> t -> int
#if OCAMLVERSION >= 4020
val unsafe_to_string : bytes -> string
val unsafe_of_string : string -> bytes
#endif
external unsafe_get : bytes -> int -> char = "%string_unsafe_get"
external unsafe_set : bytes -> int -> char -> unit = "%string_unsafe_set"
external unsafe_blit : bytes -> int -> bytes -> int -> int -> unit
  = "caml_blit_string" "noalloc"
external unsafe_fill : bytes -> int -> int -> char -> unit
  = "caml_fill_string" "noalloc"

val is_empty : bytes -> bool
val of_bool : bool -> bytes
val of_float : float -> bytes
val of_int : int -> bytes
