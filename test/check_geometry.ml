(* This is free and unencumbered software released into the public domain. *)

open Consensus.Geometry

let float =
  let module M = struct
    type t = float
    let equal = ( = )
    let pp = Format.pp_print_float
  end in
  (module M: Alcotest.TESTABLE with type t = M.t)

let tvec1 = Vector3.create 3. 1. 2.
let tvec1opposite = Vector3.create ( -3. ) ( -1. ) ( -2. )
let e = 2.71828
let pi = 3.14159
let phi = 1.61803
let tvec2 = Vector3.create e pi phi
let zerovec = Vector3.zero

let create () = Alcotest.(check int) "same int" 0 (int_of_float (Vector3.x (Vector3.zero)))
let x () = Alcotest.(check int) "same int" 3 (int_of_float (Vector3.x tvec1))
let y () = Alcotest.(check int) "same int" 1 (int_of_float (Vector3.y tvec1))
let z () = Alcotest.(check int) "same int" 2 (int_of_float (Vector3.z tvec1))
let el () = Alcotest.(check int) "same int" 3 (int_of_float (Vector3.x tvec1))
let opposite () = Alcotest.(check bool) "same bool" true (Vector3.opposite tvec1 tvec1opposite)
let opposite_failure () = Alcotest.(check bool) "same bool" false (Vector3.opposite tvec1 tvec2)

let zero () =
  Alcotest.(check (list int)) "int lists" [0; 0; 0;] ([int_of_float (Vector3.x zerovec); int_of_float (Vector3.y zerovec); int_of_float (Vector3.z zerovec)])

let equals () = Alcotest.(check bool) "same bool" true ((Vector3.zero) = (Vector3.zero))
let float_equals () = Alcotest.(check float) "same float" e (Vector3.x tvec2)

let laborious_floats () =
  Alcotest.(check float) "same float" e (Vector3.x tvec2);
  Alcotest.(check float) "same float" pi (Vector3.y tvec2);
  Alcotest.(check float) "same float" phi (Vector3.z tvec2)

let () =
  Alcotest.run "My first test" [
    "test_set", [
      "Creation", `Quick, create;
      "X", `Quick, x;
      "Y", `Quick, y;
      "Z", `Quick, z;
      "Element", `Quick, el;
      "Opposite", `Quick, opposite;
      "Opposite failure", `Quick, opposite_failure;
      "Zero", `Quick, zero;
      "Equality", `Quick, equals;
      "Float equality", `Quick, float_equals;
      "Laborious floats", `Quick, laborious_floats;
    ];
  ]
