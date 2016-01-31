(* This is free and unencumbered software released into the public domain. *)

val consensus_epsilon : float
type t = float
val infinity : float
val neg_infinity : float
val nan : float
val max_float : float
val min_float : float
val epsilon : float
val classify : float -> fpclass
type fpclass = FP_normal | FP_subnormal | FP_zero | FP_infinite | FP_nan
val is_normal : float -> bool
val is_subnormal : float -> bool
val is_zero : float -> bool
val is_infinite : float -> bool
val is_nan : float -> bool
val ( ~-. ) : float -> float
val ( ~+. ) : float -> float
val ( +. ) : float -> float -> float
val ( -. ) : float -> float -> float
val ( *. ) : float -> float -> float
val ( /. ) : float -> float -> float
val ( ** ) : float -> float -> float
val ceil : float -> float
val floor : float -> float
val abs_float : float -> float
val copysign : float -> float -> float
val mod_float : float -> float -> float
val ( %. ) : float -> float -> float
val frexp : float -> float * int
val ldexp : float -> int -> float
val modf : float -> float * float
val float : int -> float
val float_of_int : int -> float
val truncate : float -> int
val ( == ) : 'a -> 'a -> bool
val ( ==. ) : 'a -> 'a -> bool
val compare : float -> float -> int
val ( =. ) : float -> float -> bool
val ( <>. ) : float -> float -> bool
val ( >. ) : float -> float -> bool
val ( >=. ) : float -> float -> bool
val ( <. ) : float -> float -> bool
val ( <=. ) : float -> float -> bool
val min : float -> float -> float
val max : float -> float -> float
val int_of_float : float -> int
external format_float : string -> float -> string = "caml_format_float"
val valid_float_lexem : string -> string
val string_of_float : float -> string
val float_of_string : string -> float
val print_float : float -> unit
val prerr_float : float -> unit
val read_float : unit -> float
val inverse : float -> float

val of_int : int -> float
val to_int : float -> int
