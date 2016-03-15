(* This is free and unencumbered software released into the public domain. *)

open Check_common
open Consensus.Prelude

(* Prelude.Char *)

module Char_test = struct
  let of_string () =
    Alcotest.(check char) "same char"
      'z' (Char.of_string "z")

  let to_string () =
    Alcotest.(check string) "same string"
      "z" (Char.to_string 'z')

  let compare = todo
end

(* Test suite definition *)

let () =
  Alcotest.run "Consensus.Prelude.Char test suite" [
    "Char", [
      "Char.of_string", `Quick, Char_test.of_string;
      "Char.to_string", `Quick, Char_test.to_string;
      "Char.compare",   `Quick, Char_test.compare;
    ];
  ]
