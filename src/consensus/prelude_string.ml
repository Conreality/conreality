(* This is free and unencumbered software released into the public domain. *)

include String

let is_empty string =
  (length string) = 0

let of_bool value =
  Pervasives.string_of_bool value

let of_float value =
  Pervasives.string_of_float value

let of_int value =
  Pervasives.string_of_int value
