(* This is free and unencumbered software released into the public domain. *)

type t = bool

let of_string = Pervasives.bool_of_string

let to_string = Pervasives.string_of_bool

let compare (a : t) (b : t) =
  Pervasives.compare a b
