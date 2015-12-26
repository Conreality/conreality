(* This is free and unencumbered software released into the public domain. *)

open Prelude
open Parser

type t = Parser.token

let is_verb = function
  | ABORT | DISABLE | ENABLE | FIRE | HOLD | JOIN | LEAVE
  | PAN | PING | RESUME | TILT | TOGGLE | TRACK -> true
  | _ -> false
