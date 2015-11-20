(* This is free and unencumbered software released into the public domain. *)

open Check_common
open Consensus.Prelude

(* Prelude.Math *)

module Math_test = struct
  let cos () = todo ()

  let sin () = todo ()

  let tan () = todo ()
end

(* Test suite definition *)

let () =
  Alcotest.run "Consensus.Prelude.Math test suite" [
    "Math", [
      "Math.cos", `Quick, Math_test.cos;
      "Math.sin", `Quick, Math_test.sin;
      "Math.tan", `Quick, Math_test.tan;
    ];
  ]
