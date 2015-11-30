(* This is free and unencumbered software released into the public domain. *)

open Prelude

type t =
  | Unknown
  | None
  | Low
  | Medium
  | High

val to_float : t -> float
val to_string : t -> string
