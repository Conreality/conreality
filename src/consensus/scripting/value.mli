(* This is free and unencumbered software released into the public domain. *)

type t =
  | Nil
  | Boolean of bool
  | Integer of int
  | Number of float
  | String of string
  | Table of Table.t

val inspect : t -> string

val of_unit : t

val of_bool : bool -> t

val of_int : int -> t

val of_float : float -> t

val of_string : string -> t

val of_table : Table.t -> t

val to_type : t -> Type.t

val to_bool : t -> bool

val to_int : t -> int

val to_float : t -> float

val to_string : t -> string

val to_table : t -> Table.t
