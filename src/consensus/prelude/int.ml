(* This is free and unencumbered software released into the public domain. *)

type t = int

let of_float = Pervasives.int_of_float

let of_string = Pervasives.int_of_string

let to_string = Pervasives.string_of_int

let compare (a : t) (b : t) =
  Pervasives.compare a b
