(* This is free and unencumbered software released into the public domain. *)

open Consensus.Geometry

let tvec1 = Vector.create 3. 1. 2.
let e = 2.71828
let pi = 3.14159
let phi = 1.61803
let tvec2 = Vector.create e pi phi

let create () =
  Alcotest.(check int) "same int" 0 (int_of_float (Vector.x (Vector.zero ())))

let x () =
  Alcotest.(check int) "same int" 3 (int_of_float (Vector.x tvec1))

let y () =
  Alcotest.(check int) "same int" 1 (int_of_float (Vector.y tvec1))

let z () =
  Alcotest.(check int) "same int" 2 (int_of_float (Vector.z tvec1))

(*
let zero () =
  let z = Vector.zero() in
  Alcotest.(check int) "same int" 0 (int_of_float (Vector.x z)) &&
  Alcotest.(check int) "same int" 0 (int_of_float (Vector.y z)) &&
  Alcotest.(check int) "same int" 0 (int_of_float (Vector.z z))
*)

let equals () =
  Alcotest.(check bool) "same bool" true ((Vector.zero ()) = (Vector.zero ()))

let () =
  Alcotest.run "My first test" [
    "test_set", [
      "Creation", `Quick, create;
      "X", `Quick, x;
      "Y", `Quick, y;
      "Z", `Quick, z;
(*      "Zero", `Slow, zero;*)
      "Equality", `Quick, equals;
    ];
  ]
