(* This is free and unencumbered software released into the public domain. *)

open Check_common
open Consensus.Prelude

(* Prelude.Int *)

module Int_test = struct
  let of_string = todo

  let to_string = todo
end

(* Test suite definition *)

let () =
  Alcotest.run "Consensus.Prelude.Int test suite" [
    "Int", [
      "Int.of_string", `Quick, Int_test.of_string;
      "Int.to_string", `Quick, Int_test.to_string;
    ];
  ]
