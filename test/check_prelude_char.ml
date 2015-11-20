(* This is free and unencumbered software released into the public domain. *)

open Check_common
open Consensus.Prelude

(* Prelude.Char *)

module Char_test = struct
  let of_string () = todo ()
end

(* Test suite definition *)

let () =
  Alcotest.run "Consensus.Prelude.Char test suite" [
    "Char", [
      "Char.of_string", `Quick, Char_test.of_string;
    ];
  ]
