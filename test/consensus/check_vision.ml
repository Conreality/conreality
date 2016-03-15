(* This is free and unencumbered software released into the public domain. *)

open Check_common
open Consensus.Vision

(* C++ integration *)

module FFI_test = struct
  let hello () =
    (Consensus.Vision.hello ()) (* TODO *)
end

(* Test suite definition *)

let () =
  Alcotest.run "Consensus.Vision test suite" [
    "C++ glue", [
      "hello", `Quick, FFI_test.hello;
    ];
  ]
