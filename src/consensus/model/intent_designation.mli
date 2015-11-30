(* This is free and unencumbered software released into the public domain. *)

type t =
  | Unknown
  | Hostile
  | Neutral
  | Friendly

val to_float : t -> float
val to_string : t -> string
