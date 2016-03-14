(* This is free and unencumbered software released into the public domain. *)

exception Not_implemented of string

type servo = {
  pin : Bcm2835.Pin.pin;
  frequency : int;
  speed : float;
  min_pulse_width : float;
  max_pulse_width : float;
  zero_pulse_width : float;
  min_angle : float;
  max_angle : float;
}

val make :
  ?frequency:int ->
  ?speed:float ->
  ?min_pulse_width:float ->
  ?max_pulse_width:float ->
  ?zero_pulse_width:float ->
  ?min_angle:float -> ?max_angle:float ->
  int -> servo

val goto : servo -> float -> unit
val goto_relative : servo -> float -> unit

val get_position : servo -> float

(* fixme: last three not implemented yet *)
val get_speed : servo -> float
val get_eta : servo -> float
val tell_position : servo -> float
