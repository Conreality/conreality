(* This is free and unencumbered software released into the public domain. *)

open Check_common
open Consensus.Prelude
open Consensus.Prelude.Math

(* Prelude.Float *)

module Float_test = struct
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
  let eq_p1 () = same_bool false (Float.( =. ) fp1 (fp1 +. (0.001)))
  let eq_p2 () = same_bool false (Float.( =. ) fp2 (fp2 +. (0.00000001)))
  let eq_p3 () = same_bool false (Float.( =. ) fp3 (fp3 +. (0.000000001)))
  let eq_p4 () = same_bool true (Float.( =. ) fp4 (fp4 +. (0.0000000001)))
  let eq_p5 () = same_bool true (Float.( =. ) fp5 (fp5 +. (0.00000000001)))
  let eq_p6 () = same_bool false (Float.( =. ) fp6 (fp6 +. (0.0000001)))
  let eq_p7 () = same_bool false (Float.( =. ) fp7 (fp7 +. (0.00000001)))
  let eq_p8 () = same_bool true (Float.( =. ) fp8 (fp8 +. (0.0000000001)))
  let eq_p9 () = same_bool true (Float.( =. ) fp9 (fp9 +. (0.00000000001)))
  let eq_p10 () = same_bool false (Float.( =. ) fp10 (fp10 +. (1.)))
  let eq_p11 () = same_bool false (Float.( =. ) fp11 (fp11 +. (1.)))
  let eq_p12 () = same_bool true (Float.( =. ) fp12 (fp12 +. (1.)))
  let eq_p13 () = same_bool true (Float.( =. ) fp13 (fp13 +. (1.)))

  (* classification *)

  let is_normal () =
    same_bool true (Float.is_normal 1.);
    same_bool false (Float.is_normal (2. ** (-1047.)))

  let is_subnormal () =
    same_bool true (Float.is_subnormal (2. ** (-1047.)));
    same_bool false (Float.is_subnormal 1.)

  let is_zero () =
    same_bool true (Float.is_zero 0.);
    same_bool false (Float.is_zero 1.)

  let is_infinite () =
    same_bool true (Float.is_infinite (1. /. 0.));
    same_bool false (Float.is_infinite 1.)

  let is_nan () =
    same_bool true (Float.is_nan (asin 7.));
    same_bool false (Float.is_nan 1.)

  let fi0 = 1.
  let fi1 = fi0

  let op_ident () = same_bool true (Float.( == ) fi0 fi1)

  let op_ident_dot () = same_bool true (Float.( ==. ) fi0 fi1)

  let compare () =
    same_int 0 (Float.compare 1. 1.);
    same_int (-1) (Float.compare 1. 2.);
    same_int 1 (Float.compare 2. 1.);
    same_int (-1) (Float.compare 1. infinity);
    same_int 1 (Float.compare infinity 1.);
    same_int (-1) (Float.compare 0.1 1.);
    same_int 1 (Float.compare 1. 0.1);
    same_int 1 (Float.compare 0.2 0.1);
    same_int 0 (Float.compare 1. (1. +. 1e-10))

  let eq_dot () =
    (* Everything else in prelude_float.(=) gets checked via the precision tests *)
    same_bool false (Float.( =. ) 1. infinity);
    same_bool false (Float.( =. ) infinity 1.)

  let neq_dot () = same_bool true (Float.( <>. ) 1. 2.)

  let gt_dot () =
    same_bool true (Float.( >. ) 2. 1.);
    same_bool false (Float.( >. ) 1. 2.)

  let ge_dot () =
    same_bool true (Float.( >=. ) 2. 1.);
    same_bool true (Float.( >=. ) 2. 2.);
    same_bool false (Float.( >=. ) 1. 2.)

  let lt_dot () =
    same_bool true (Float.( <. ) 1. 2.);
    same_bool false (Float.( <. ) 2. 1.)

  let le_dot () =
    same_bool true (Float.( <=. ) 1. 2.);
    same_bool true (Float.( <=. ) 2. 2.);
    same_bool false (Float.( <=. ) 2. 1.)

  let min () =
    same_float 1. (Float.min 1. 2.);
    same_float 1. (Float.min 2. 1.)

  let max () =
    same_float 2. (Float.max 2. 1.);
    same_float 2. (Float.max 1. 2.)

  let string_of_float () = same_string "3.14159" (Float.string_of_float 3.14159)

  let inverse () =
    same_float 0.5 (Float.inverse 2.);
    same_float 0. (Float.inverse Float.infinity);
    same_float Float.infinity (Float.inverse 0.)
end

let () =
  Alcotest.run "Consensus.Prelude.Float test suite" [
    "Float", [
      "Float.eq_p1",                `Quick, Float_test.eq_p1;
      "Float.eq_p2",                `Quick, Float_test.eq_p2;
      "Float.eq_p3",                `Quick, Float_test.eq_p3;
      "Float.eq_p4",                `Quick, Float_test.eq_p4;
      "Float.eq_p5",                `Quick, Float_test.eq_p5;
      "Float.eq_p6",                `Quick, Float_test.eq_p6;
      "Float.eq_p7",                `Quick, Float_test.eq_p7;
      "Float.eq_p8",                `Quick, Float_test.eq_p8;
      "Float.eq_p9",                `Quick, Float_test.eq_p9;
      "Float.eq_p10",               `Quick, Float_test.eq_p10;
      "Float.eq_p11",               `Quick, Float_test.eq_p11;
      "Float.eq_p12",               `Quick, Float_test.eq_p12;
      "Float.eq_p13",               `Quick, Float_test.eq_p13;
      "Float.is_normal",            `Quick, Float_test.is_normal;
      "Float.is_subnormal",         `Quick, Float_test.is_subnormal;
      "Float.is_zero",              `Quick, Float_test.is_zero;
      "Float.is_infinite",          `Quick, Float_test.is_infinite;
      "Float.is_nan",               `Quick, Float_test.is_nan;
      "Float.op_ident",             `Quick, Float_test.op_ident;
      "Float.op_ident_dot",         `Quick, Float_test.op_ident_dot;
      "Float.compare",              `Quick, Float_test.compare;
      "Float.eq_dot",               `Quick, Float_test.eq_dot;
      "Float.neq_dot",              `Quick, Float_test.neq_dot;
      "Float.gt_dot",               `Quick, Float_test.gt_dot;
      "Float.ge_dot",               `Quick, Float_test.ge_dot;
      "Float.lt_dot",               `Quick, Float_test.lt_dot;
      "Float.le_dot",               `Quick, Float_test.le_dot;
      "Float.min",                  `Quick, Float_test.min;
      "Float.max",                  `Quick, Float_test.max;
      "Float.string_of_float",      `Quick, Float_test.string_of_float;
      "Float.inverse",              `Quick, Float_test.inverse;
    ];
  ]

