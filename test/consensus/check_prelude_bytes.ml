(* This is free and unencumbered software released into the public domain. *)

open Check_common
open Consensus.Prelude

(* Prelude.Bytes *)

module Bytes_test = struct
  let is_empty () =
    same_bool true (Bytes.is_empty (Bytes.of_string ""));
    same_bool false (Bytes.is_empty (Bytes.of_string "a"))
end

(* Test suite definition *)

let () =
  Alcotest.run "Consensus.Prelude.Bytes test suite" [
    "Bytes", [
      "Bytes.is_empty", `Quick, Bytes_test.is_empty;
    ];
  ]
