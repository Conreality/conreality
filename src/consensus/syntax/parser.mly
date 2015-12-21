(* This is free and unencumbered software released into the public domain. *)

%token <string> SYMBOL
%token <int> INTEGER
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

%{
  open Command
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

  | FIRE device=symbol duration=integer
  { Fire (device, float_of_int duration) }

  | HOLD
  { Hold }

  | JOIN swarm=symbol
  { Join (swarm) }

  | LEAVE swarm=symbol
  { Leave (swarm) }

  | PAN direction=pan_direction degrees=integer
  { Pan (direction *. (float_of_int degrees)) }

  | PING node=symbol
  { Ping (node) }

  | RESUME
  { Resume }

  | TILT direction=tilt_direction degrees=integer
  { Tilt (direction *. (float_of_int degrees)) }

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

(*
value:
  | symbol    { $1 }
  | integer   { $1 }
*)

symbol:
  | string=SYMBOL   { String.lowercase string }

integer:
  | integer=INTEGER { integer }
