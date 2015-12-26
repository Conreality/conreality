(* This is free and unencumbered software released into the public domain. *)

%token <string> SYMBOL
%token <int> INTEGER
%token <float> FLOAT
%token EOF

(* Command verbs: *)
%token ABORT
%token DISABLE
%token ENABLE
%token FIRE
%token HOLD
%token JOIN
%token LEAVE
%token PAN
%token PING
%token RESUME
%token TILT
%token TOGGLE
%token TRACK

(* Rotation directions: *)
%token DOWN
%token LEFT
%token RIGHT
%token UP

(* Prepositions: *)
%token TO

(* Quantifiers: *)
%token DEGREES
%token OCLOCK
%token RADIANS
%token SECONDS

%{
  open Command
  open Exception

  let sprintf = Printf.sprintf
  let pi = 4. *. atan 1.

  let radians rad = rad

  let degrees_to_radians deg =
    if deg >= 0. && deg <= 360.
    then (mod_float deg 360.) *. (pi /. 180.)
    else semantic_error (sprintf "degrees must be in range 0 to 360 (got %f)" deg)

  let clock_to_radians pos =
    if pos >= 0. && pos <= 12.
    then degrees_to_radians (360. /. 12.) *. (mod_float pos 12.)
    else semantic_error (sprintf "clock positions must be in range 0 to 12 (got %f)" pos)
%}

%start <Command.t> parse

%%

parse:
  | command EOF { $1 }

command:
  | ABORT
    { Abort }

  | DISABLE device=symbol
    { Disable (device) }

  | ENABLE device=symbol
    { Enable (device) }

  | FIRE device=symbol duration=duration
    { Fire (device, duration) }

  | HOLD
    { Hold }

  | JOIN swarm=symbol
    { Join (swarm) }

  | LEAVE swarm=symbol
    { Leave (swarm) }

  | PAN direction=pan_direction radians=angle
    { Pan (direction *. radians) }

  | PAN TO radians=angle
    { PanTo radians }

  | PING node=symbol
    { Ping (node) }

  | RESUME
    { Resume }

  | TILT direction=tilt_direction radians=angle
    { Tilt (direction *. radians) }

  | TILT TO radians=angle
    { TiltTo radians }

  | TOGGLE device=symbol
    { Toggle (device) }

  | TRACK target=symbol
    { Track (target) }

pan_direction:
  | LEFT      { -1. }
  | RIGHT     { +1. }

tilt_direction:
  | DOWN      { -1. }
  | UP        { +1. }

symbol:
  | string=SYMBOL { String.lowercase string }

angle:
  | rad=number RADIANS { radians rad }
  | deg=number DEGREES { degrees_to_radians deg }
  | pos=number OCLOCK  { clock_to_radians pos }

duration:
  | sec=number SECONDS { sec }

number:
  | float=FLOAT     { float }
  | integer=INTEGER { float_of_int integer }
