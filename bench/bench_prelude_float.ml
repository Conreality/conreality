(* This is free and unencumbered software released into the public domain. *)

open Core.Std
open Core_bench.Std
open Consensus.Prelude_float

let () =
  let f0 = 0. in
  let f1 = 1. in
  (*let f1n = (-1.) in*)
  Command.run (Bench.make_command [
      Bench.Test.create ~name:"Float.(=.)"
        (fun () -> ignore (f0 = f0));
      Bench.Test.create ~name:"Float.(==.)"
        (fun () -> ignore (f0 ==. f0));
      Bench.Test.create ~name:"Float.(<)"
        (fun () -> ignore (f0 < f1));
      Bench.Test.create ~name:"Float.(<.)"
        (fun () -> ignore (f0 <. f1));
      Bench.Test.create ~name:"Float.(>)"
        (fun () -> ignore (f0 > f1));
      Bench.Test.create ~name:"Float.(>.)"
        (fun () -> ignore (f0 >. f1));
      Bench.Test.create ~name:"Float.(<=)"
        (fun () -> ignore (f0 <= f1));
      Bench.Test.create ~name:"Float.(<=.)"
        (fun () -> ignore (f0 <=. f1));
      Bench.Test.create ~name:"Float.(>=)"
        (fun () -> ignore (f0 >= f1));
      Bench.Test.create ~name:"Float.(>=.)"
        (fun () -> ignore (f0 >=. f1));
    ])
