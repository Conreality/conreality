(* This is free and unencumbered software released into the public domain. *)

include Char

let zero = '\x00'

let of_int = chr

let to_int = code

let of_int32 n = of_int (Int32.to_int n)

let to_int32 c = Int32.of_int (to_int c)

let of_int64 n = of_int (Int64.to_int n)

let to_int64 c = Int64.of_int (to_int c)

let of_string s = String.get s 0

let to_string c = String.make 1 c

let compare (a : t) (b : t) =
  Pervasives.compare a b
