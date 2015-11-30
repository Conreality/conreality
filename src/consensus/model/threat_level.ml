(* This is free and unencumbered software released into the public domain. *)

open Prelude

type t =
  | Unknown
  | None
  | Low
  | Medium
  | High

let to_float = function
  | Unknown -> Float.nan
  | None    -> 0.0
  | Low     -> 0.25
  | Medium  -> 0.5
  | High    -> 1.

let to_string = function
  | Unknown -> "Unknown"
  | None    -> "None"
  | Low     -> "Low"
  | Medium  -> "Medium"
  | High    -> "High"
