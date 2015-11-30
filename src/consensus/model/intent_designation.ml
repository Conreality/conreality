(* This is free and unencumbered software released into the public domain. *)

open Prelude

type t =
  | Unknown
  | Hostile
  | Neutral
  | Friendly

let to_float = function
  | Unknown  -> Float.nan
  | Hostile  -> -1.
  | Neutral  -> 0.
  | Friendly -> 1.

let to_string = function
  | Unknown  -> "Unknown"
  | Hostile  -> "Hostile"
  | Neutral  -> "Neutral"
  | Friendly -> "Friendly"
