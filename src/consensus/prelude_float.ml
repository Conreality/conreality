(* This is free and unencumbered software released into the public domain. *)

(* This is as good as we get with 32-bit floats (e.g. on ARMv6) *)
let consensus_epsilon = 1e-9

type t = float

(* floating-point constants from Pervasives *)
(* BISECT-IGNORE-BEGIN *)
let infinity          = Pervasives.infinity
let neg_infinity      = Pervasives.neg_infinity
let nan               = Pervasives.nan
let max_float         = Pervasives.max_float
let min_float         = Pervasives.min_float
let epsilon           = Pervasives.epsilon_float
(* BISECT-IGNORE-END *)

(* constants from /usr/include/math.h *)
let e                 = 2.7182818284590452354  (* e *)
let log2_e            = 1.4426950408889634074  (* log_2 e *)
let log10_e           = 0.43429448190325182765 (* log_10 e *)
let ln_2              = 0.69314718055994530942 (* log_e 2 *)
let ln_10             = 2.30258509299404568402 (* log_e 10 *)
let pi                = 3.14159265358979323846 (* pi *)
let pi_over_2         = 1.57079632679489661923 (* pi/2 *)
let pi_over_4         = 0.78539816339744830962 (* pi/4 *)
let inv_pi            = 0.31830988618379067154 (* 1/pi *)
let sqrt_2            = 1.41421356237309504880 (* sqrt(2) *)
let inv_sqrt_2        = 0.70710678118654752440 (* 1/sqrt(2) *)

(* float classifcation*)
let classify = Pervasives.classify_float

type fpclass =
  | FP_normal
  | FP_subnormal
  | FP_zero
  | FP_infinite
  | FP_nan
;;

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

(* XXX: It may be faster to use
 * let is_nan f = f <> f *)
let is_nan f =
  match classify f with
  | FP_nan -> true
  | _      -> false

(* Floating-point operations *)
(* BISECT-IGNORE-BEGIN *)
let ( ~-. ) x         = Pervasives.( ~-. ) x
let ( ~+. ) x         = Pervasives.( ~+. ) x
let ( +. ) x y        = Pervasives.( +. ) x y
let ( -. ) x y        = Pervasives.( -. ) x y
let ( *. ) x y        = Pervasives.( *. ) x y
let ( /. ) x y        = Pervasives.( /. ) x y
let ( ** ) x y        = Pervasives.( ** ) x y
let exp x             = Pervasives.exp x
let expm1 x           = Pervasives.expm1 x
let sqrt x            = Pervasives.sqrt x
let log x             = Pervasives.log x
let log10 x           = Pervasives.log10 x
let log1p x           = Pervasives.log1p x
(* BISECT-IGNORE-END *)

(* Trigonometric functions, inverses, hyperbolics and inverse hyperbolics *)
(* XXX: Do we need bounds-checking for x on some of these? *)
(* BISECT-IGNORE-BEGIN *)
let sin x             = Pervasives.sin x
let cos x             = Pervasives.cos x
let tan x             = Pervasives.tan x
(* BISECT-IGNORE-END *)
let csc x             = 1. /. (sin x)
let sec x             = 1. /. (cos x)
let cot x             = (cos x) /. (sin x)
(* BISECT-IGNORE-BEGIN *)
let asin x            = Pervasives.asin x
let acos x            = Pervasives.acos x
let atan x            = Pervasives.atan x
let atan2 x y         = Pervasives.atan2 x y
(* BISECT-IGNORE-END *)
let acsc x            = asin (1. /. x)
let asec x            = acos (1. /. x)
let acot x            = pi_over_2 -. (atan x)
(* BISECT-IGNORE-BEGIN *)
let sinh x            = Pervasives.sinh x
let cosh x            = Pervasives.cosh x
let tanh x            = Pervasives.tanh x
(* BISECT-IGNORE-END *)
let csch x            = 1. /. (sinh x)
let sech x            = 1. /. (cosh x)
let coth x            = 1. /. (tanh x)
let asinh x           = log (x +. sqrt (x ** 2. +. 1.))
let acosh x           = log (x +. sqrt (x ** 2. -. 1.))
let atanh x           = (log ((1. +. x) /. (1. -. x))) /. 2.
let acsch x           = asinh (1. /. x)
let asech x           = acosh (1. /. x)
let acoth x           = (log ((1. -. x) /. (1. +. x))) /. 2.
let hypot x y         = Pervasives.hypot x y (* BISECT-IGNORE *)

(* BISECT-IGNORE-BEGIN *)
let ceil x            = Pervasives.ceil x
let floor x           = Pervasives.floor x
let abs_float x       = Pervasives.abs_float x
let copysign x y      = Pervasives.copysign x y
let mod_float x y     = Pervasives.mod_float x y
let ( %. ) x y        = Pervasives.mod_float x y
let frexp x           = Pervasives.frexp x
let ldexp x i         = Pervasives.ldexp x i
let modf x            = Pervasives.modf x
let float i           = Pervasives.float i
let float_of_int i    = Pervasives.float_of_int i
let truncate x        = Pervasives.truncate x
(* BISECT-IGNORE-END *)

(* Floating-point comparisons *)
let ( == ) x y = x = y
let ( ==. ) x y = x = y

let compare x y =
  let c = Pervasives.compare x y in
  if c = 0 then 0 else
    let ax = abs_float x in
    let ay = abs_float y in
    let amax = if ax > ay then ax else ay in
    let max = if 1. > amax then 1. else amax in
    if max = infinity then c else
    if abs_float (x -. y) <= consensus_epsilon *. max then 0 else c

let ( =. ) x y =
  let c = Pervasives.compare x y in
  if c = 0 then true else
    let ax = abs_float x in
    let ay = abs_float y in
    let amax = if ax > ay then ax else ay in
    let max = if 1. > amax then 1. else amax in
    if max = infinity then false else
      abs_float (x -. y) <= consensus_epsilon *. max

let ( <>. ) x y = not (x =. y)

let ( >. ) x y =
  match (compare x y) with
  | 1  -> true
  | _  -> false
let ( >=. ) x y =
  match (compare x y) with
  | 1  -> true
  | 0  -> true
  | _  -> false
let ( <. ) x y =
  match (compare x y) with
  | -1 -> true
  | _  -> false
let ( <=. ) x y =
  match (compare x y) with
  | -1 -> true
  | 0  -> true
  | _  -> false

(* min/max *)
let min x y =
  if (x <>. x) then y else
  if (y <. x) then y else x

let max x y =
  if (x <>. x) then y else
  if (x <. y) then y else x

(* Conversions *)
let int_of_float x = Pervasives.int_of_float x (* BISECT-IGNORE *)
external format_float : string -> float -> string = "caml_format_float"
let valid_float_lexem s = Pervasives.valid_float_lexem s (* BISECT-IGNORE *)
(* TODO: Do we need to switch 12 to 9 here? *)
let string_of_float x = valid_float_lexem (format_float "%.12g" x)
let float_of_string s = Pervasives.float_of_string s (* BISECT-IGNORE *)

(* Other stuff *)
(* BISECT-IGNORE-BEGIN *)
let print_float x = Pervasives.print_float x
let prerr_float x = Pervasives.prerr_float x
let read_float () = Pervasives.read_float ()
