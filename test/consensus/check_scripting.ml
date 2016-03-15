(* This is free and unencumbered software released into the public domain. *)

open Check_common
open Consensus.Scripting

(* Scripting.Context *)

module Context_test = struct
  open Context

  let create () = todo ()

  let load_code () = todo ()

  let load_file () = todo ()

  let eval_code () = todo ()

  let eval_file () = todo ()

  let get_string () = todo ()
end

(* Test suite definition *)

let () =
  Alcotest.run "Consensus.Scripting test suite" [
    "Context", [
      "Context.create",     `Quick, Context_test.create;
      "Context.load_code",  `Quick, Context_test.load_code;
      "Context.load_file",  `Quick, Context_test.load_file;
      "Context.eval_code",  `Quick, Context_test.eval_code;
      "Context.eval_file",  `Quick, Context_test.eval_file;
      "Context.get_string", `Quick, Context_test.get_string;
    ];
  ]
