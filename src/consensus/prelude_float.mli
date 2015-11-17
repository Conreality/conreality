(* This is free and unencumbered software released into the public domain. *)

val consensus_epsilon : float
type t = float
val infinity : float
val neg_infinity : float
val nan : float
val max_float : float
val min_float : float
val epsilon : float
val e : float
val log2_e : float
val log10_e : float
val ln_2 : float
val ln_10 : float
val pi : float
val pi_over_2 : float
val pi_over_4 : float
val inv_pi : float
val sqrt_2 : float
val inv_sqrt_2 : float
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
val exp : float -> float
val expm1 : float -> float
val sqrt : float -> float
val log : float -> float
val log10 : float -> float
val log1p : float -> float
val sin : float -> float
val cos : float -> float
val tan : float -> float
val csc : float -> float
val sec : float -> float
val cot : float -> float
val asin : float -> float
val acos : float -> float
val atan : float -> float
val atan2 : float -> float -> float
val acsc : float -> float
val asec : float -> float
val acot : float -> float
val sinh : float -> float
val cosh : float -> float
val tanh : float -> float
val csch : float -> float
val sech : float -> float
val coth : float -> float
val asinh : float -> float
val acosh : float -> float
val atanh : float -> float
val acsch : float -> float
val asech : float -> float
val acoth : float -> float
val hypot : float -> float -> float
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
