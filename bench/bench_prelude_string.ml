(* This is free and unencumbered software released into the public domain. *)

open Core.Std
open Core_bench.Std
open Consensus.Prelude_string

let () =
  let s0 = "" in
  let s1 = "supercalifragilisticexpialidocious" in
  Command.run (Bench.make_command [
      Bench.Test.create ~name:"empty"
        (fun () -> ignore (is_empty s0));
      Bench.Test.create ~name:"not empty"
        (fun () -> ignore (is_empty s1));
    ])

