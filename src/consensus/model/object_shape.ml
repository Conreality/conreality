(* This is free and unencumbered software released into the public domain. *)

open Prelude

type t =
  | Unknown

let to_string = function
  | Unknown -> "Unknown"
