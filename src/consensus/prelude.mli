(* This is free and unencumbered software released into the public domain. *)

module Float : sig
  type t = float
  val infinity : float
  val neg_infinity : float
  val nan : float
  val max : float
  val min : float
  val epsilon : float
  val classify : float -> fpclass
  val is_normal : float -> bool
  val is_subnormal : float -> bool
  val is_zero : float -> bool
  val is_infinite : float -> bool
  val is_nan : float -> bool
end
