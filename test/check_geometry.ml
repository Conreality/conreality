(* This is free and unencumbered software released into the public domain. *)

open Consensus.Geometry

let float =
  let module M = struct
    type t = float
    let equal = ( = )
    let pp = Format.pp_print_float
  end in
  (module M: Alcotest.TESTABLE with type t = M.t)

let todo () = Alcotest.(check bool) "PASS" true true

let tvec3_1 = V3.create 3. 1. 2.
let tvec3_1opposite = V3.create ( -3. ) ( -1. ) ( -2. )
let e = 2.71828
let pi = 3.14159
let phi = 1.61803
let tvec3_2 = V3.create e pi phi
let tvec3_0 = V3.zero

let v3_create () = Alcotest.(check int) "same int" 0 (int_of_float (V3.x (V3.zero)))
let v3_x () = Alcotest.(check int) "same int" 3 (int_of_float (V3.x tvec3_1))
let v3_y () = Alcotest.(check int) "same int" 1 (int_of_float (V3.y tvec3_1))
let v3_z () = Alcotest.(check int) "same int" 2 (int_of_float (V3.z tvec3_1))
let v3_el () = Alcotest.(check int) "same int" 3 (int_of_float (V3.x tvec3_1))
let v3_zero () = Alcotest.(check (list float)) "float list" [0.; 0.; 0.;] ([V3.x tvec3_0; V3.y tvec3_0; V3.z tvec3_0])
let v3_unitx () = todo ()
let v3_unity () = todo ()
let v3_unitz () = todo ()
let v3_invert () = todo ()
let v3_neg () = todo()
let v3_op_neg () = todo ()
let v3_add () = todo ()
let v3_op_add () = todo ()
let v3_sub () = todo ()
let v3_op_sub () = todo ()
let v3_eq () = todo ()
let v3_op_eq () = Alcotest.(check bool) "same bool" true ((V3.zero) = (V3.zero))
let v3_float_equals () = Alcotest.(check float) "same float" e (V3.x tvec3_2)
let v3_smul () = todo ()
let v3_op_smul () = todo ()
let v3_opposite () = Alcotest.(check bool) "same bool" true (V3.opposite tvec3_1 tvec3_1opposite)
let v3_opposite_failure () = Alcotest.(check bool) "same bool" false (V3.opposite tvec3_1 tvec3_2)
let v3_dotproduct () = todo ()
let v3_crossproduct () = todo ()
let v3_magnitude () = todo ()
let v3_magnitude2 () = todo ()
let v3_normalize () = todo ()
let v3_distance () = todo ()

let v3_laborious_floats () =
  Alcotest.(check float) "same float" e (V3.x tvec3_2);
  Alcotest.(check float) "same float" pi (V3.y tvec3_2);
  Alcotest.(check float) "same float" phi (V3.z tvec3_2)

let () =
  Alcotest.run "My first test" [
    "test_set", [
      "v3 create",               `Quick, v3_create;
      "v3 x",                    `Quick, v3_x;
      "v3 y",                    `Quick, v3_y;
      "v3 z",                    `Quick, v3_z;
      "v3 element",              `Quick, v3_el;
      "v3 zero",                 `Quick, v3_zero;
      "v3 unitx",                `Quick, v3_unitx;
      "v3 unity",                `Quick, v3_unity;
      "v3 unitz",                `Quick, v3_unitz;
      "v3 invert",               `Quick, v3_invert;
      "v3 neg",                  `Quick, v3_neg;
      "v3 op_neg",               `Quick, v3_op_neg;
      "v3 add",                  `Quick, v3_add;
      "v3 op_add",               `Quick, v3_op_add;
      "v3 sub",                  `Quick, v3_sub;
      "v3 op_sub",               `Quick, v3_op_sub;
      "v3 eq",                   `Quick, v3_eq;
      "v3 op_eq",                `Quick, v3_op_eq;
      "v3 float equality",       `Quick, v3_float_equals;
      "v3 smul",                 `Quick, v3_smul;
      "v3 op_smul",              `Quick, v3_op_smul;
      "v3 opposite",             `Quick, v3_opposite;
      "v3 opposite failure",     `Quick, v3_opposite_failure;
      "v3 dot product",          `Quick, v3_dotproduct;
      "v3 cross product",        `Quick, v3_crossproduct;
      "v3 magnitude",            `Quick, v3_magnitude;
      "v3 magnitude2",           `Quick, v3_magnitude2;
      "v3 normalize",            `Quick, v3_normalize;
      "v3 distance",             `Quick, v3_distance;
      "v3 laborious floats",     `Quick, v3_laborious_floats;
    ];
  ]

