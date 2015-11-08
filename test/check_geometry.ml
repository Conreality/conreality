(* This is free and unencumbered software released into the public domain. *)

open Consensus.Geometry

let create () =
  Alcotest.(check int) "same int" 0 (int_of_float (Vector.x (Vector.zero ())))

let equals () =
  Alcotest.(check (bool)) "same bool" true ((Vector.zero ()) = (Vector.zero ()))

let () =
  Alcotest.run "My first test" [
    "test_set", [
      "Creation", `Quick, create;
      "Equality", `Quick, equals;
    ];
  ]
