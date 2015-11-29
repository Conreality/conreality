(* This is free and unencumbered software released into the public domain. *)

include Bytes

let is_empty bytes = (Bytes.length bytes) = 0

let of_bool value =
  Bytes.of_string (Pervasives.string_of_bool value) (*BISECT-IGNORE*)

let of_float value =
  Bytes.of_string (Pervasives.string_of_float value) (*BISECT-IGNORE*)

let of_int value =
  Bytes.of_string (Pervasives.string_of_int value) (*BISECT-IGNORE*)
