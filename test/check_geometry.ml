(* This is free and unencumbered software released into the public domain. *)

open Consensus.Geometry

let tvec1 = Vector3.create 3. 1. 2.
let e = 2.71828
let pi = 3.14159
let phi = 1.61803
let tvec2 = Vector3.create e pi phi

let create () =
  Alcotest.(check int) "same int" 0 (int_of_float (Vector3.x (Vector3.zero)))

let x () =
  Alcotest.(check int) "same int" 3 (int_of_float (Vector3.x tvec1))

let y () =
  Alcotest.(check int) "same int" 1 (int_of_float (Vector3.y tvec1))

let z () =
  Alcotest.(check int) "same int" 2 (int_of_float (Vector3.z tvec1))

let el () =
  Alcotest.(check int) "same int" 3 (int_of_float (Vector3.x tvec1))

(*
let zero () =
  let z = Vector3.zero() in
  Alcotest.(check int) "same int" 0 (int_of_float (Vector3.x z)) &&
  Alcotest.(check int) "same int" 0 (int_of_float (Vector3.y z)) &&
  Alcotest.(check int) "same int" 0 (int_of_float (Vector3.z z))
*)

let equals () =
  Alcotest.(check bool) "same bool" true ((Vector3.zero) = (Vector3.zero))

let () =
  Alcotest.run "My first test" [
    "test_set", [
      "Creation", `Quick, create;
      "X", `Quick, x;
      "Y", `Quick, y;
      "Z", `Quick, z;
      "Element", `Quick, el;
(*      "Zero", `Slow, zero;*)
      "Equality", `Quick, equals;
    ];
  ]
