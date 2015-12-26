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
  | HELP
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

let is_eof = function
  | EOF -> true | _ -> false

let is_verb = function
  | ABORT | DISABLE | ENABLE | FIRE | HELP | HOLD | JOIN | LEAVE
  | PAN | PING | RESUME | TILT | TOGGLE | TRACK -> true
  | _ -> false

let is_numeric = function
  | FLOAT _ | INTEGER _ -> true | _ -> false

let to_string  = function
  | ABORT     -> "abort"
  | DEGREES   -> "degrees"
  | DISABLE   -> "disable"
  | DOWN      -> "down"
  | ENABLE    -> "enable"
  | EOF       -> ""
  | FIRE      -> "fire"
  | FLOAT f   -> Printf.sprintf "%f" f
  | HELP      -> "help"
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

let action_for tokens =
  match tokens with
  | [] -> None
  | ABORT as k :: _   -> Some (to_string k)
  | DISABLE as k :: _ -> Some (to_string k)
  | ENABLE as k :: _  -> Some (to_string k)
  | FIRE as k :: _    -> Some (to_string k)
  | HELP as k :: _    -> Some (to_string k)
  | HOLD as k :: _    -> Some (to_string k)
  | JOIN as k :: _    -> Some (to_string k)
  | LEAVE as k :: _   -> Some (to_string k)
  | PAN as k :: (TO as k' :: _)  ->
    Some (Printf.sprintf "%s %s" (to_string k) (to_string k'))
  | PAN as k :: _     -> Some (to_string k)
  | PING as k :: _    -> Some (to_string k)
  | RESUME as k :: _  -> Some (to_string k)
  | TILT as k :: (TO as k' :: _) ->
    Some (Printf.sprintf "%s %s" (to_string k) (to_string k'))
  | TILT as k :: _    -> Some (to_string k)
  | TOGGLE as k :: _  -> Some (to_string k)
  | TRACK as k :: _   -> Some (to_string k)
  | _  -> None
