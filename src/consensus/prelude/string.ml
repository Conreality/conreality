(* This is free and unencumbered software released into the public domain. *)

include String

let is_empty string = (length string) = 0

let of_bool = Pervasives.string_of_bool (*BISECT-IGNORE*)

let of_float = Pervasives.string_of_float (*BISECT-IGNORE*)

let of_int = Pervasives.string_of_int (*BISECT-IGNORE*)
