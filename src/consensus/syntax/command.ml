(* This is free and unencumbered software released into the public domain. *)

open Prelude

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

let to_string = function
  | Abort -> "abort()"
  | Disable device ->
    Printf.sprintf "disable(%s)" device
  | Enable device ->
    Printf.sprintf "enable(%s)" device
  | Fire (device, duration) ->
    Printf.sprintf "fire(%s, %f)" device duration
  | Hold -> "hold()"
  | Join swarm ->
    Printf.sprintf "join(%s)" swarm
  | Leave swarm ->
    Printf.sprintf "leave(%s)" swarm
  | Pan degrees ->
    Printf.sprintf "pan(%f)" degrees
  | Ping node ->
    Printf.sprintf "ping(%s)" node
  | Resume -> "resume()"
  | Tilt degrees ->
    Printf.sprintf "tilt(%f)" degrees
  | Toggle device ->
    Printf.sprintf "toggle(%s)" device
  | Track target ->
    Printf.sprintf "track(%s)" target

let length command =
  (String.length (to_string command))
