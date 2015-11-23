(* This is free and unencumbered software released into the public domain. *)

(* This is as good as we get with 32-bit floats (e.g. on ARMv6) *)
let consensus_epsilon = 1e-9

type t = float

(* floating-point constants from Pervasives *)
(*BISECT-IGNORE-BEGIN*)
let infinity          = Pervasives.infinity
let neg_infinity      = Pervasives.neg_infinity
let nan               = Pervasives.nan
let max_float         = Pervasives.max_float
let min_float         = Pervasives.min_float
let epsilon           = Pervasives.epsilon_float
(*BISECT-IGNORE-END*)

(* float classifcation *)
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
(*BISECT-IGNORE-BEGIN*)
let ( ~-. ) x         = Pervasives.( ~-. ) x
let ( ~+. ) x         = Pervasives.( ~+. ) x
let ( +. ) x y        = Pervasives.( +. ) x y
let ( -. ) x y        = Pervasives.( -. ) x y
let ( *. ) x y        = Pervasives.( *. ) x y
let ( /. ) x y        = Pervasives.( /. ) x y
let ( ** ) x y        = Pervasives.( ** ) x y
(*BISECT-IGNORE-END*)

(*BISECT-IGNORE-BEGIN*)
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
(*BISECT-IGNORE-END*)

(* Floating-point comparisons *)
(* TODO: shouldn't these tests use Pervasives.(==) instead of =? *)
let ( == ) x y = x = y
let ( ==. ) x y = x = y

let compare x y =
  let c = Pervasives.compare x y in
  if c = 0 then 0 else
    let ax = abs_float x in
    let ay = abs_float y in
    let amax = if ax > ay then ax else ay in
    let max =
      if 1. > amax then
        1.
      else
        amax in
    if max = infinity then c else
    if abs_float (x -. y) <= consensus_epsilon *. max then 0 else c

let ( =. ) x y =
  let c = Pervasives.compare x y in
  if c = 0 then true else
    let ax = abs_float x in
    let ay = abs_float y in
    let amax = if ax > ay then ax else ay in
    let max = if 1. > amax then 1. else amax in
    if max = infinity then false
    else abs_float (x -. y) <= consensus_epsilon *. max

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
  if (y <. x) then y else x

let max x y =
  if (x <. y) then y else x

(* Conversions *)
(*BISECT-IGNORE-BEGIN*)
let int_of_float x = Pervasives.int_of_float x
external format_float : string -> float -> string = "caml_format_float"
let valid_float_lexem s = Pervasives.valid_float_lexem s
(*BISECT-IGNORE-END*)
(* TODO: Do we need to switch 12 to 9 here? *)
let string_of_float x = valid_float_lexem (format_float "%.12g" x)
let float_of_string s = Pervasives.float_of_string s (*BISECT-IGNORE*)

(* Other stuff *)
(*BISECT-IGNORE-BEGIN*)
let print_float x = Pervasives.print_float x
let prerr_float x = Pervasives.prerr_float x
let read_float () = Pervasives.read_float ()
(*BISECT-IGNORE-END*)
