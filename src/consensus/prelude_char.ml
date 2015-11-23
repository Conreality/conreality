(* This is free and unencumbered software released into the public domain. *)

include Char

let of_string s = String.get s 0

let to_string c = String.make 1 c

let compare (a : t) (b : t) =
  Pervasives.compare a b
