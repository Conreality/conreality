(* This is free and unencumbered software released into the public domain. *)

type t =
  | UP
  | TRACK
  | TOGGLE
  | TO
  | TILT
  | SYMBOL of string
  | SECONDS
  | RIGHT
  | RESUME
  | RADIANS
  | PING
  | PAN
  | OCLOCK
  | LEFT
  | LEAVE
  | JOIN
  | INTEGER of int
  | HOLD
  | FLOAT of float
  | FIRE
  | EOF
  | ENABLE
  | DOWN
  | DISABLE
  | DEGREES
  | ABORT

type token = t

let is_verb = function
  | ABORT | DISABLE | ENABLE | FIRE | HOLD | JOIN | LEAVE
  | PAN | PING | RESUME | TILT | TOGGLE | TRACK -> true
  | _ -> false
