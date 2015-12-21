(* This is free and unencumbered software released into the public domain. *)

type t =
  | Abort
  | Disable of string
  | Enable of string
  | Fire of string * float
  | Hold
  | Join of string
  | Leave of string
  | Pan of float
  | Ping of string
  | Resume
  | Tilt of float
  | Toggle of string
  | Track of string
