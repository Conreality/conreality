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

let tvec1 = V3.create 3. 1. 2.
let tvec1opposite = V3.create ( -3. ) ( -1. ) ( -2. )
let e = 2.71828
let pi = 3.14159
let phi = 1.61803
let tvec2 = V3.create e pi phi
let vec0 = V3.zero

let create () = Alcotest.(check int) "same int" 0 (int_of_float (V3.x (V3.zero)))
let x () = Alcotest.(check int) "same int" 3 (int_of_float (V3.x tvec1))
let y () = Alcotest.(check int) "same int" 1 (int_of_float (V3.y tvec1))
let z () = Alcotest.(check int) "same int" 2 (int_of_float (V3.z tvec1))
let el () = Alcotest.(check int) "same int" 3 (int_of_float (V3.x tvec1))
let zero () = Alcotest.(check (list float)) "float list" [0.; 0.; 0.;] ([V3.x vec0; V3.y vec0; V3.z vec0])
let unitx () = todo ()
let unity () = todo ()
let unitz () = todo ()
let invert () = todo ()
let op_neg () = todo ()
let op_add () = todo ()
let op_sub () = todo ()
let op_eq () = Alcotest.(check bool) "same bool" true ((V3.zero) = (V3.zero))
let float_equals () = Alcotest.(check float) "same float" e (V3.x tvec2)
let smul () = todo ()
let op_smul () = todo ()
let opposite () = Alcotest.(check bool) "same bool" true (V3.opposite tvec1 tvec1opposite)
let opposite_failure () = Alcotest.(check bool) "same bool" false (V3.opposite tvec1 tvec2)
let dotproduct () = todo ()
let crossproduct () = todo ()
let magnitude () = todo ()
let magnitude2 () = todo ()
let normalize () = todo ()
let distance () = todo ()

let laborious_floats () =
  Alcotest.(check float) "same float" e (V3.x tvec2);
  Alcotest.(check float) "same float" pi (V3.y tvec2);
  Alcotest.(check float) "same float" phi (V3.z tvec2)

let () =
  Alcotest.run "My first test" [
    "test_set", [
      "v3 create",               `Quick, create;
      "v3 x",                    `Quick, x;
      "v3 y",                    `Quick, y;
      "v3 z",                    `Quick, z;
      "v3 element",              `Quick, el;
      "v3 zero",                 `Quick, zero;
      "v3 unitx",                `Quick, unitx;
      "v3 unity",                `Quick, unity;
      "v3 unitz",                `Quick, unitz;
      "v3 invert",               `Quick, invert;
      "v3 op_neg",               `Quick, op_neg;
      "v3 op_add",               `Quick, op_add;
      "v3 op_sub",               `Quick, op_sub;
      "v3 op_eq",                `Quick, op_eq;
      "v3 float equality",       `Quick, float_equals;
      "v3 smul",                 `Quick, smul;
      "v3 op_smul",              `Quick, op_smul;
      "v3 opposite",             `Quick, opposite;
      "v3 opposite failure",     `Quick, opposite_failure;
      "v3 dot product",          `Quick, dotproduct;
      "v3 cross product",        `Quick, crossproduct;
      "v3 magnitude",            `Quick, magnitude;
      "v3 magnitude2",           `Quick, magnitude2;
      "v3 normalize",            `Quick, normalize;
      "v3 distance",             `Quick, distance;
      "v3 laborious floats",     `Quick, laborious_floats;
      "v3 blind pass",           `Quick, todo;
    ];
  ]
