(* This is free and unencumbered software released into the public domain. *)

open Check_common
open Consensus.Prelude
open Consensus.Prelude.Float

(* Prelude.Math *)

module Math_test = struct
  let tan () = todo ()

  (* Trigonometric functions, inverses, hyperbolics and inverse hyperbolics *)
  (* Values used here were calculated in GNU Octave *)

  let csc () =
    same_float 1.188395105778121241 (Math.csc 1.);
    same_bool true (is_infinite (Math.csc 0.))

  let sec () =
    same_float 1.850815717680925454 (Math.sec 1.);
    same_bool true (is_nan (Math.sec infinity))

  let cot () =
    same_float 6.420926159343306461e-01 (Math.cot 1.);
    same_bool true (is_infinite (Math.cot 0.))

  let acsc () =
    same_float 1.570796326794896558 (Math.acsc 1.);
    same_float 0. (Math.acsc 10000000000000000.)

  let asec () =
    same_float 0. (Math.asec 1.);
    same_float 1.570796326794896558 (Math.asec infinity);
    same_bool true (is_nan (Math.asec 0.))

  let acot () =
    same_float 7.853981633974482790e-01 (Math.acot 1.);
    same_float 0. (Math.acot infinity)

  let csch () =
    same_float 8.509181282393215584e-01 (Math.csch 1.);
    same_bool true (is_infinite (Math.csch 0.))

  let sech () =
    same_float 6.480542736638854606e-01 (Math.sech 1.);
    same_float 1. (Math.sech 0.)

  let coth () =
    same_float 1.313035285499331462 (Math.coth 1.);
    same_bool true (is_infinite (Math.coth 0.))

  let acsch () =
    same_float 8.813735870195430477e-01 (Math.acsch 1.);
    same_bool true (is_infinite (Math.acsch 0.))

  let asech () =
    same_float 0. (Math.asech 1.);
    same_bool true (is_infinite (Math.asech 0.))

  let acoth () =
    same_float 5.493061443340547800e-01 (Math.acoth 2.);
    same_bool true (is_infinite (Math.acoth 1.));
    same_bool true (is_nan (Math.acoth 0.))

  let asinh () =
    same_float 8.813735870195430477e-01 (Math.asinh 1.);
    same_float 0. (Math.asinh 0.);
    same_bool true (is_infinite (Math.asinh infinity))

  let acosh () =
    same_float 1.316957896924816573e+00 (Math.acosh 2.);
    same_bool true (is_infinite (Math.acosh infinity))

  let atanh () =
    same_float infinity (Math.atanh 1.);
    same_float 1.003353477310755804e-01 (Math.atanh 0.1);
    same_float 0. (Math.atanh 0.)

end

(* Test suite definition *)

let () =
  Alcotest.run "Consensus.Prelude.Math test suite" [
    "Math", [
      "Math.tan", `Quick, Math_test.tan;
      "Math.csc",                  `Quick, Math_test.csc;
      "Math.sec",                  `Quick, Math_test.sec;
      "Math.cot",                  `Quick, Math_test.cot;
      "Math.acsc",                 `Quick, Math_test.acsc;
      "Math.asec",                 `Quick, Math_test.asec;
      "Math.acot",                 `Quick, Math_test.acot;
      "Math.csch",                 `Quick, Math_test.csch;
      "Math.sech",                 `Quick, Math_test.sech;
      "Math.coth",                 `Quick, Math_test.coth;
      "Math.acsch",                `Quick, Math_test.acsch;
      "Math.asech",                `Quick, Math_test.asech;
      "Math.asinh",                `Quick, Math_test.asinh;
      "Math.acosh",                `Quick, Math_test.acosh;
      "Math.atanh",                `Quick, Math_test.atanh;
      "Math.acoth",                `Quick, Math_test.acoth;
    ];
  ]
