(* This is free and unencumbered software released into the public domain. *)

open Consensus.Prelude
(* TODO: Don't open the module under test *)
open Consensus.Prelude.Float
open Consensus.Prelude.Math
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

let fi0 = 1.
let fi1 = fi0

let f_op_ident () = same_bool true (fi0 == fi1)

let f_op_ident_dot () = same_bool true (fi0 ==. fi1)

let f_compare () =
  same_int 0 (compare 1. 1.);
  same_int (-1) (compare 1. 2.);
  same_int 1 (compare 2. 1.);
  same_int (-1) (compare 1. infinity);
  same_int 1 (compare infinity 1.);
  same_int (-1) (compare 0.1 1.);
  same_int 1 (compare 1. 0.1);
  same_int 1 (compare 0.2 0.1);
  same_int 0 (compare 1. (1. +. 1e-10))

let f_eq_dot () =
  (* Everything else in prelude_float.(=) gets checked via the precision tests *)
  same_bool false (1. =. infinity);
  same_bool false (infinity =. 1.)

let f_neq_dot () = same_bool true (1. <>. 2.)

let f_gt_dot () =
  same_bool true (2. >. 1.);
  same_bool false (1. >. 2.)

let f_ge_dot () =
  same_bool true (2. >=. 1.);
  same_bool true (2. >=. 2.);
  same_bool false (1. >=. 2.)

let f_lt_dot () =
  same_bool true (1. <. 2.);
  same_bool false (2. <. 1.)

let f_le_dot () =
  same_bool true (1. <=. 2.);
  same_bool true (2. <=. 2.);
  same_bool false (2. <=. 1.)

let f_min () =
  same_float 1. (min 1. 2.);
  same_float 1. (min 2. 1.)

let f_max () =
  same_float 2. (max 2. 1.);
  same_float 2. (max 1. 2.)

let f_string_of_float () = same_string "3.14159" (string_of_float 3.14159)

let () =
  Alcotest.run "prelude_float" [
    "test_set", [
      "f_eq_p1",                `Quick, f_eq_p1;
      "f_eq_p2",                `Quick, f_eq_p2;
      "f_eq_p3",                `Quick, f_eq_p3;
      "f_eq_p4",                `Quick, f_eq_p4;
      "f_eq_p5",                `Quick, f_eq_p5;
      "f_eq_p6",                `Quick, f_eq_p6;
      "f_eq_p7",                `Quick, f_eq_p7;
      "f_eq_p8",                `Quick, f_eq_p8;
      "f_eq_p9",                `Quick, f_eq_p9;
      "f_eq_p10",               `Quick, f_eq_p10;
      "f_eq_p11",               `Quick, f_eq_p11;
      "f_eq_p12",               `Quick, f_eq_p12;
      "f_eq_p13",               `Quick, f_eq_p13;
      "f_is_normal",            `Quick, f_is_normal;
      "f_is_subnormal",         `Quick, f_is_subnormal;
      "f_is_zero",              `Quick, f_is_zero;
      "f_is_infinite",          `Quick, f_is_infinite;
      "f_is_nan",               `Quick, f_is_nan;
      "f_op_ident",             `Quick, f_op_ident;
      "f_op_ident_dot",         `Quick, f_op_ident_dot;
      "f_compare",              `Quick, f_compare;
      "f_eq_dot",               `Quick, f_eq_dot;
      "f_neq_dot",              `Quick, f_neq_dot;
      "f_gt_dot",               `Quick, f_gt_dot;
      "f_ge_dot",               `Quick, f_ge_dot;
      "f_lt_dot",               `Quick, f_lt_dot;
      "f_le_dot",               `Quick, f_le_dot;
      "f_min",                  `Quick, f_min;
      "f_max",                  `Quick, f_max;
      "f_string_of_float",      `Quick, f_string_of_float;
    ];
  ]

