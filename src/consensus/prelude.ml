(* This is free and unencumbered software released into the public domain. *)

module Float = struct
  type t = float

  let infinity = Pervasives.infinity

  let neg_infinity = Pervasives.neg_infinity

  let nan = Pervasives.nan

  let max = Pervasives.max_float

  let min = Pervasives.min_float

  let epsilon = Pervasives.epsilon_float

  let classify = Pervasives.classify_float

  let is_normal f =
    match classify f with
    | FP_normal -> true
    | _         -> false

  let is_subnormal f =
    match classify f with
    | FP_subnormal -> true
    | _            -> false

  let is_zero f =
    match classify f with
    | FP_zero -> true
    | _       -> false

  let is_infinite f =
    match classify f with
    | FP_infinite -> true
    | _           -> false

  let is_nan f =
    match classify f with
    | FP_nan -> true
    | _      -> false
end
