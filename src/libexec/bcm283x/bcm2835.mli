(* This is free and unencumbered software released into the public domain. *)

module Pin :
  sig
    exception Unknown_pin of int

    type pin = P12_BCM18 | P35_BCM19 | P32_BCM12 | P33_BCM13

    val of_int : int -> pin
    val to_string : pin -> string
  end

(*    module Gpio :  not needed currently, later will need it if we add modes in/out
  sig
    val set_mode_to_pwm : Pin.pin -> unit
  end
*)

module Pwm :
  sig
    val get_pwm_range : Pin.pin -> int
    val set_pwm_range : Pin.pin -> int -> unit
    val get_pulse_data : Pin.pin -> int
    val set_pulse_data : Pin.pin -> int -> unit
  end

module Clock :
  sig
    exception Clock_value_out_of_range of int
    val set_divisor : int -> unit
    val get_divisor : unit -> int
  end

val init_pin        : ?divisor:int -> Pin.pin -> unit
val get_frequency   : Pin.pin -> int
val set_frequency   : Pin.pin -> int -> unit
val get_pulse_width : Pin.pin -> float
val set_pulse_width : Pin.pin -> float -> unit
