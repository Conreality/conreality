(* This is free and unencumbered software released into the public domain. *)

open Consensus.Prelude
open Consensus.Prelude.Float
open Check_common

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
    ];
  ]

