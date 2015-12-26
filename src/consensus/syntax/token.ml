(* This is free and unencumbered software released into the public domain. *)

type t =
  | ABORT
  | DEGREES
  | DISABLE
  | DOWN
  | ENABLE
  | EOF
  | FIRE
  | FLOAT of float
  | HOLD
  | INTEGER of int
  | JOIN
  | LEAVE
  | LEFT
  | OCLOCK
  | PAN
  | PING
  | RADIANS
  | RESUME
  | RIGHT
  | SECONDS
  | SYMBOL of string
  | TILT
  | TO
  | TOGGLE
  | TRACK
  | UP

type token = t

let is_verb = function
  | ABORT | DISABLE | ENABLE | FIRE | HOLD | JOIN | LEAVE
  | PAN | PING | RESUME | TILT | TOGGLE | TRACK -> true
  | _ -> false

let to_string  = function
  | ABORT     -> "abort"
  | DEGREES   -> "degrees"
  | DISABLE   -> "disable"
  | DOWN      -> "down"
  | ENABLE    -> "enable"
  | EOF       -> ""
  | FIRE      -> "fire"
  | FLOAT f   -> Printf.sprintf "%f" f
  | HOLD      -> "hold"
  | INTEGER n -> Printf.sprintf "%d" n
  | JOIN      -> "join"
  | LEAVE     -> "leave"
  | LEFT      -> "left"
  | OCLOCK    -> "o'clock"
  | PAN       -> "pan"
  | PING      -> "ping"
  | RADIANS   -> "radians"
  | RESUME    -> "resume"
  | RIGHT     -> "right"
  | SECONDS   -> "seconds"
  | SYMBOL s  -> s
  | TILT      -> "tilt"
  | TO        -> "to"
  | TOGGLE    -> "toggle"
  | TRACK     -> "track"
  | UP        -> "up"
