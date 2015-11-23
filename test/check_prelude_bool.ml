(* This is free and unencumbered software released into the public domain. *)

open Check_common
open Consensus.Prelude

(* Prelude.Bool *)

module Bool_test = struct
  let of_string = todo

  let to_string = todo
end

(* Test suite definition *)

let () =
  Alcotest.run "Consensus.Prelude.Bool test suite" [
    "Bool", [
      "Bool.of_string", `Quick, Bool_test.of_string;
      "Bool.to_string", `Quick, Bool_test.to_string;
    ];
  ]
