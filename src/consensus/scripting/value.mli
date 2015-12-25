(* This is free and unencumbered software released into the public domain. *)

type t =
  | Nil
  | Boolean of bool
  | Integer of int
  | Number of float
  | String of string

val of_unit : t

val of_bool : bool -> t

val of_int : int -> t

val of_float : float -> t

val of_string : string -> t

val to_string : t -> string
