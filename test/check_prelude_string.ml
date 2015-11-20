(* This is free and unencumbered software released into the public domain. *)

open Check_common
open Consensus.Prelude

(* Prelude.String *)

module String_test = struct
  let is_empty () = todo ()
  let of_bool () = todo ()
  let of_float () = todo ()
  let of_int () = todo ()
end

(* Test suite definition *)

let () =
  Alcotest.run "Consensus.Prelude.String test suite" [
    "String", [
      "String.is_empty", `Quick, String_test.is_empty;
      "String.of_bool",  `Quick, String_test.of_bool;
      "String.of_float", `Quick, String_test.of_float;
      "String.of_int",   `Quick, String_test.of_int;
    ];
  ]
