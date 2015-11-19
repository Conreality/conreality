(* This is free and unencumbered software released into the public domain. *)

open Consensus.Prelude
open Consensus.Prelude.Float
open Check_common

(* Equality with precision checking *)

let fp1 = (3.01)
let fp2 = (0.30000001)
let fp3 = (0.300000001)
let fp4 = (0.3000000001)
let fp5 = (0.30000000001)
let fp6 = (-0.000001)
let fp7 = (-0.0000001)
let fp8 = (-0.000000001)
let fp9 = (-0.0000000001)
let fp10 = (12345678.)
let fp11 = (123456789.)
let fp12 = (1234567890.)
let fp13 = (12345678901.)

(* TODO: Rewrite these so values created by are actually related to Float.eps *)
let f_eq_p1 () = same_bool false (fp1 =. (fp1 +. (0.001)))
let f_eq_p2 () = same_bool false (fp2 =. (fp2 +. (0.00000001)))
let f_eq_p3 () = same_bool false (fp3 =. (fp3 +. (0.000000001)))
let f_eq_p4 () = same_bool true (fp4 =. (fp4 +. (0.0000000001)))
let f_eq_p5 () = same_bool true (fp5 =. (fp5 +. (0.00000000001)))
let f_eq_p6 () = same_bool false (fp6 =. (fp6 +. (0.0000001)))
let f_eq_p7 () = same_bool false (fp7 =. (fp7 +. (0.00000001)))
let f_eq_p8 () = same_bool true (fp8 =. (fp8 +. (0.0000000001)))
let f_eq_p9 () = same_bool true (fp9 =. (fp9 +. (0.00000000001)))
let f_eq_p10 () = same_bool false (fp10 =. (fp10 +. (1.)))
let f_eq_p11 () = same_bool false (fp11 =. (fp11 +. (1.)))
let f_eq_p12 () = same_bool true (fp12 =. (fp12 +. (1.)))
let f_eq_p13 () = same_bool true (fp13 =. (fp13 +. (1.)))

(* classification *)

let f_is_normal () =
  same_bool true (is_normal 1.);
  same_bool false (is_normal (2. ** (-1047.)))

let f_is_subnormal () =
  same_bool true (is_subnormal (2. ** (-1047.)));
  same_bool false (is_subnormal 1.)

let f_is_zero () =
  same_bool true (is_zero 0.);
  same_bool false (is_zero 1.)

let f_is_infinite () =
  same_bool true (is_infinite (1. /. 0.));
  same_bool false (is_infinite 1.)

let f_is_nan () =
  same_bool true (is_nan (asin 7.));
  same_bool false (is_nan 1.)

(* Trigonometric functions, inverses, hyperbolics and inverse hyperbolics *)

let f_csc () =
  same_float 1.188395105778121241 (csc 1.);
  same_bool true (is_infinite (csc 0.))

let f_sec () =
  same_float 1.850815717680925454 (sec 1.);
  same_bool true (is_nan (sec infinity))

let f_cot () =
  same_float 6.420926159343306461e-01 (cot 1.);
  same_bool true (is_infinite (cot 0.))

let f_acsc () =
  same_float 1.570796326794896558 (acsc 1.);
  same_float 0. (acsc 10000000000000000.)

let f_asec () =
  same_float 0. (asec 1.);
  same_float 1.570796326794896558 (asec infinity);
  same_bool true (is_nan (asec 0.))

let f_acot () =
  same_float 7.853981633974482790e-01 (acot 1.);
  same_float 0. (acot infinity)

let f_csch () =
  same_float 8.509181282393215584e-01 (csch 1.);
  same_bool true (is_infinite (csch 0.))

let f_sech () =
  same_float 6.480542736638854606e-01(sech 1.);
  same_float 1. (sech 0.)

let f_coth () =
  same_float 1.313035285499331462 (coth 1.);
  same_bool true (is_infinite (coth 0.))

let f_acsch () =
  same_float 8.813735870195430477e-01 (acsch 1.);
  same_bool true (is_infinite (acsch 0.))

let f_asech () =
  same_float 0. (asech 1.);
  same_bool true (is_infinite (asech 0.))

let f_acoth () =
  same_float 5.493061443340547800e-01 (acoth 2.);
  same_bool true (is_infinite (acoth 1.));
  same_bool true (is_nan (acoth 0.))

let f_asinh () =
  same_float 8.813735870195430477e-01 (asinh 1.);
  same_float 0. (asinh 0.);
  same_bool true (is_infinite (asinh infinity))

let f_acosh () =
  same_float 1.316957896924816573e+00 (acosh 2.);
  same_bool true (is_infinite (acosh infinity))

let f_atanh () =
  same_float infinity (atanh 1.);
  same_float 1.003353477310755804e-01 (atanh 0.1);
  same_float 0. (atanh 0.)

let fi0 = 1.
let fi1 = fi0
let f_op_ident () = same_bool true (fi0 == fi1)
let f_op_ident_dot () = same_bool true (fi0 ==. fi1)

let f_compare () = same_int 0 (compare 1. 1.); same_int (-1) (compare 1. 2.); same_int 1 (compare 2. 1.); same_int (-1) (compare 1. infinity); same_int 1 (compare infinity 1.)
let f_neq_dot () = same_bool true (1. <>. 2.)
let f_gt_dot () = same_bool true (2. >. 1.); same_bool false (1. >. 2.)
let f_ge_dot () = same_bool true (2. >=. 1.); same_bool true (2. >=. 2.); same_bool false (1. >=. 2.)
let f_lt_dot () = same_bool true (1. <. 2.); same_bool false (2. <. 1.)
let f_le_dot () = same_bool true (1. <=. 2.); same_bool true (2. <=. 2.); same_bool false (2. <=. 1.)
let f_min () = same_float 1. (min 1. 2.); same_float 1. (min 2. 1.)
let f_max () = same_float 2. (max 2. 1.); same_float 2. (max 1. 2.)
let f_string_of_float () = same_string "3.14159" (string_of_float 3.14159)

let () =
  Alcotest.run "My first test" [
    "test_set", [
      "f_eq_p1",        `Quick, f_eq_p1;
      "f_eq_p2",        `Quick, f_eq_p2;
      "f_eq_p3",        `Quick, f_eq_p3;
      "f_eq_p4",        `Quick, f_eq_p4;
      "f_eq_p5",        `Quick, f_eq_p5;
      "f_eq_p6",        `Quick, f_eq_p6;
      "f_eq_p7",        `Quick, f_eq_p7;
      "f_eq_p8",        `Quick, f_eq_p9;
      "f_eq_p9",        `Quick, f_eq_p9;
      "f_eq_p10",       `Quick, f_eq_p10;
      "f_eq_p11",       `Quick, f_eq_p11;
      "f_eq_p12",       `Quick, f_eq_p12;
      "f_eq_p13",       `Quick, f_eq_p13;
      "f_is_normal",    `Quick, f_is_normal;
      "f_is_subnormal", `Quick, f_is_subnormal;
      "f_is_zero",      `Quick, f_is_zero;
      "f_is_infinite",  `Quick, f_is_infinite;
      "f_is_nan",       `Quick, f_is_nan;
      "f_csc",          `Quick, f_csc;
      "f_sec",          `Quick, f_sec;
      "f_cot",          `Quick, f_cot;
      "f_acsc",         `Quick, f_acsc;
      "f_asec",         `Quick, f_asec;
      "f_acot",         `Quick, f_acot;
      "f_csch",         `Quick, f_csch;
      "f_sech",         `Quick, f_sech;
      "f_coth",         `Quick, f_coth;
      "f_acsch",        `Quick, f_acsch;
      "f_asech",        `Quick, f_asech;
      "f_asinh",        `Quick, f_asinh;
      "f_acosh",        `Quick, f_acosh;
      "f_atanh",        `Quick, f_atanh;
      "f_acoth",        `Quick, f_acoth;
      "f_op_ident",     `Quick, f_op_ident;
      "f_op_ident_dot", `Quick, f_op_ident_dot;
      "f_compare",      `Quick, f_compare;
      "f_neq_dot",      `Quick, f_neq_dot;
      "f_gt_dot",       `Quick, f_gt_dot;
      "f_ge_dot",       `Quick, f_ge_dot;
      "f_lt_dot",       `Quick, f_lt_dot;
      "f_le_dot",       `Quick, f_le_dot;
      "f_min",          `Quick, f_min;
      "f_max",          `Quick, f_max;
      "f_string_of_float",`Quick, f_string_of_float;
    ];
  ]

