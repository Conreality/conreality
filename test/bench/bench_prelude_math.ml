(* This is free and unencumbered software released into the public domain. *)

open Core.Std
open Core_bench.Std
open Consensus.Prelude
open Consensus.Prelude_float
open Consensus.Prelude_math

let () =
  let f0 = 0. in
  let f1 = 1. in
  Command.run (Bench.make_command [
      Bench.Test.create ~name:"Math.exp"
        (fun () -> ignore (exp f0));
      Bench.Test.create ~name:"Math.expm1"
        (fun () -> ignore (expm1 f0));
      Bench.Test.create ~name:"Math.sqrt"
        (fun () -> ignore (sqrt f0));
      Bench.Test.create ~name:"Math.log"
        (fun () -> ignore (log f0));
      Bench.Test.create ~name:"Math.log10"
        (fun () -> ignore (log10 f0));
      Bench.Test.create ~name:"Math.log1p"
        (fun () -> ignore (log1p f0));
      Bench.Test.create ~name:"Math.sin"
        (fun () -> ignore (sin f0));
      Bench.Test.create ~name:"Math.cos"
        (fun () -> ignore (cos f0));
      Bench.Test.create ~name:"Math.tan"
        (fun () -> ignore (tan f0));
      Bench.Test.create ~name:"Math.csc"
        (fun () -> ignore (csc f0));
      Bench.Test.create ~name:"Math.sec"
        (fun () -> ignore (sec f0));
      Bench.Test.create ~name:"Math.cot"
        (fun () -> ignore (cot f0));
      Bench.Test.create ~name:"Math.asin"
        (fun () -> ignore (asin f0));
      Bench.Test.create ~name:"Math.acos"
        (fun () -> ignore (acos f0));
      Bench.Test.create ~name:"Math.atan"
        (fun () -> ignore (atan f0));
      Bench.Test.create ~name:"Math.atan2"
        (fun () -> ignore (atan2 f0 f1));
      Bench.Test.create ~name:"Math.acsc"
        (fun () -> ignore (acsc f0));
      Bench.Test.create ~name:"Math.asec"
        (fun () -> ignore (asec f0));
      Bench.Test.create ~name:"Math.acot"
        (fun () -> ignore (acot f0));
      Bench.Test.create ~name:"Math.sinh"
        (fun () -> ignore (sinh f0));
      Bench.Test.create ~name:"Math.cosh"
        (fun () -> ignore (cosh f0));
      Bench.Test.create ~name:"Math.tanh"
        (fun () -> ignore (tanh f0));
      Bench.Test.create ~name:"Math.csch"
        (fun () -> ignore (csch f0));
      Bench.Test.create ~name:"Math.sech"
        (fun () -> ignore (sech f0));
      Bench.Test.create ~name:"Math.coth"
        (fun () -> ignore (coth f0));
      Bench.Test.create ~name:"Math.asinh"
        (fun () -> ignore (asinh f0));
      Bench.Test.create ~name:"Math.acosh"
        (fun () -> ignore (acosh f0));
      Bench.Test.create ~name:"Math.atanh"
        (fun () -> ignore (atanh f0));
      Bench.Test.create ~name:"Math.acsch"
        (fun () -> ignore (acsch f0));
      Bench.Test.create ~name:"Math.asech"
        (fun () -> ignore (asech f0));
      Bench.Test.create ~name:"Math.acoth"
        (fun () -> ignore (acoth f0));
      Bench.Test.create ~name:"Math.hypot"
        (fun () -> ignore (hypot f0 f1));
    ])
