(* This is free and unencumbered software released into the public domain. *)

(* constants from /usr/include/math.h *)
let e                 = 2.7182818284590452354  (* e *)
let log2_e            = 1.4426950408889634074  (* log_2 e *)
let log10_e           = 0.43429448190325182765 (* log_10 e *)
let ln_2              = 0.69314718055994530942 (* log_e 2 *)
let ln_10             = 2.30258509299404568402 (* log_e 10 *)
let pi                = 3.14159265358979323846 (* pi (4. *. atan 1.) *)
let pi_over_2         = 1.57079632679489661923 (* pi/2 *)
let pi_over_4         = 0.78539816339744830962 (* pi/4 *)
let inv_pi            = 0.31830988618379067154 (* 1/pi *)
let sqrt_2            = 1.41421356237309504880 (* sqrt(2) *)
let inv_sqrt_2        = 0.70710678118654752440 (* 1/sqrt(2) *)

(*BISECT-IGNORE-BEGIN*)
let exp x             = Pervasives.exp x
let expm1 x           = Pervasives.expm1 x
let sqrt x            = Pervasives.sqrt x
let log x             = Pervasives.log x
let log10 x           = Pervasives.log10 x
let log1p x           = Pervasives.log1p x
(*BISECT-IGNORE-END*)

(* Trigonometric functions, inverses, hyperbolics and inverse hyperbolics *)
(* XXX: Do we need bounds-checking for x on some of these? *)
(*BISECT-IGNORE-BEGIN*)
let sin x             = Pervasives.sin x
let cos x             = Pervasives.cos x
let tan x             = Pervasives.tan x
(*BISECT-IGNORE-END*)

let csc x             = 1. /. (sin x)
let sec x             = 1. /. (cos x)
let cot x             = (cos x) /. (sin x)

(*BISECT-IGNORE-BEGIN*)
let asin x            = Pervasives.asin x
let acos x            = Pervasives.acos x
let atan x            = Pervasives.atan x
let atan2 x y         = Pervasives.atan2 x y
(*BISECT-IGNORE-END*)

let acsc x            = asin (1. /. x)
let asec x            = acos (1. /. x)
let acot x            = pi_over_2 -. (atan x)

(*BISECT-IGNORE-BEGIN*)
let sinh x            = Pervasives.sinh x
let cosh x            = Pervasives.cosh x
let tanh x            = Pervasives.tanh x
(*BISECT-IGNORE-END*)

let csch x            = 1. /. (sinh x)
let sech x            = 1. /. (cosh x)
let coth x            = 1. /. (tanh x)
let asinh x           = log (x +. sqrt (x ** 2. +. 1.))
let acosh x           = log (x +. sqrt (x ** 2. -. 1.))
let atanh x           = (log ((1. +. x) /. (1. -. x))) /. 2.
let acsch x           = asinh (1. /. x)
let asech x           = acosh (1. /. x)
let acoth x           = (log (1. +. (1. /. x)) -. log (1. -. (1. /. x))) /. 2.

let hypot x y         = Pervasives.hypot x y (*BISECT-IGNORE*)

