(* This is free and unencumbered software released into the public domain. *)

type t =
  | Nil
  | Boolean
  | Integer
  | Number
  | String
  | Table

val to_string : t -> string
