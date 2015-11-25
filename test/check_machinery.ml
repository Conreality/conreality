(* This is free and unencumbered software released into the public domain. *)

open Check_common
open Consensus.Machinery

(* Machinery.GPIO.Mode *)

let mode =
  let module M = struct
    open Consensus.Machinery.GPIO
    type t = Mode.t
    let equal a b = a = b
    let pp formatter mode = Format.pp_print_string formatter (Mode.to_string mode)
  end in
  (module M: Alcotest.TESTABLE with type t = M.t)

let same_mode a b = Alcotest.(check mode) "same GPIO mode" a b

module GPIO_Mode_test = struct
  open GPIO

  let of_string () =
    same_mode Mode.Input (Mode.of_string "in");
    same_mode Mode.Output (Mode.of_string "out")

  let to_string () =
    same_string "in" (Mode.to_string Mode.Input);
    same_string "out" (Mode.to_string Mode.Output)

  let of_bytes () =
    List.iter
      (fun input -> same_mode Mode.Input (Mode.of_bytes (Bytes.of_string input)))
      ["in"; "in\n"; "in\n\x00"];
    List.iter
      (fun input -> same_mode Mode.Output (Mode.of_bytes (Bytes.of_string input)))
      ["out"; "out\n"; "out\n\x00"]

  let to_bytes () =
    same_bytes (Bytes.of_string "in") (Mode.to_bytes Mode.Input);
    same_bytes (Bytes.of_string "out") (Mode.to_bytes Mode.Output)
end

(* Test suite definition *)

let () =
  Alcotest.run "Consensus.Machinery test suite" [
    "GPIO.Mode", [
      "Mode.of_string", `Quick, GPIO_Mode_test.of_string;
      "Mode.to_string", `Quick, GPIO_Mode_test.to_string;
      "Mode.of_bytes",  `Quick, GPIO_Mode_test.of_bytes;
      "Mode.to_bytes",  `Quick, GPIO_Mode_test.to_bytes;
    ];
    "GPIO.Pin", [
      (* TODO *)
    ];
  ]
