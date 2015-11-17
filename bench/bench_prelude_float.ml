(* This is free and unencumbered software released into the public domain. *)

open Core.Std
open Core_bench.Std
open Consensus.Prelude_float

let () =
  let f0 = 0. in
  let f1 = 1. in
  let i0 = 1 in
  let s0 = "1.234" in
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
      Bench.Test.create ~name:"Float.classify"
        (fun () -> ignore (classify f0));
      Bench.Test.create ~name:"Float.is_normal"
        (fun () -> ignore (is_normal f0));
      Bench.Test.create ~name:"Float.is_subnormal"
        (fun () -> ignore (is_subnormal f0));
      Bench.Test.create ~name:"Float.is_zero"
        (fun () -> ignore (is_zero f0));
      Bench.Test.create ~name:"Float.is_infinite"
        (fun () -> ignore (is_infinite f0));
      Bench.Test.create ~name:"Float.is_nan"
        (fun () -> ignore (is_nan f0));
      Bench.Test.create ~name:"Float.(~-.)"
        (fun () -> ignore (~-. f0));
      Bench.Test.create ~name:"Float.(~+.)"
        (fun () -> ignore (~+. f0));
      Bench.Test.create ~name:"Float.(+.)"
        (fun () -> ignore (f0 +. f1));
      Bench.Test.create ~name:"Float.(-.)"
        (fun () -> ignore (f0 -. f1));
      Bench.Test.create ~name:"Float.(*.)"
        (fun () -> ignore (f0 *. f1));
      Bench.Test.create ~name:"Float.(/.)"
        (fun () -> ignore (f0 /. f1));
      Bench.Test.create ~name:"Float.(**)"
        (fun () -> ignore (f0 ** f1));
      Bench.Test.create ~name:"Float.exp"
        (fun () -> ignore (exp f0));
      Bench.Test.create ~name:"Float.expm1"
        (fun () -> ignore (expm1 f0));
      Bench.Test.create ~name:"Float.sqrt"
        (fun () -> ignore (sqrt f0));
      Bench.Test.create ~name:"Float.log"
        (fun () -> ignore (log f0));
      Bench.Test.create ~name:"Float.log10"
        (fun () -> ignore (log10 f0));
      Bench.Test.create ~name:"Float.log1p"
        (fun () -> ignore (log1p f0));
      Bench.Test.create ~name:"Float.sin"
        (fun () -> ignore (sin f0));
      Bench.Test.create ~name:"Float.cos"
        (fun () -> ignore (cos f0));
      Bench.Test.create ~name:"Float.tan"
        (fun () -> ignore (tan f0));
      Bench.Test.create ~name:"Float.csc"
        (fun () -> ignore (csc f0));
      Bench.Test.create ~name:"Float.sec"
        (fun () -> ignore (sec f0));
      Bench.Test.create ~name:"Float.cot"
        (fun () -> ignore (cot f0));
      Bench.Test.create ~name:"Float.asin"
        (fun () -> ignore (asin f0));
      Bench.Test.create ~name:"Float.acos"
        (fun () -> ignore (acos f0));
      Bench.Test.create ~name:"Float.atan"
        (fun () -> ignore (atan f0));
      Bench.Test.create ~name:"Float.atan2"
        (fun () -> ignore (atan2 f0 f1));
      Bench.Test.create ~name:"Float.acsc"
        (fun () -> ignore (acsc f0));
      Bench.Test.create ~name:"Float.asec"
        (fun () -> ignore (asec f0));
      Bench.Test.create ~name:"Float.acot"
        (fun () -> ignore (acot f0));
      Bench.Test.create ~name:"Float.sinh"
        (fun () -> ignore (sinh f0));
      Bench.Test.create ~name:"Float.cosh"
        (fun () -> ignore (cosh f0));
      Bench.Test.create ~name:"Float.tanh"
        (fun () -> ignore (tanh f0));
      Bench.Test.create ~name:"Float.csch"
        (fun () -> ignore (csch f0));
      Bench.Test.create ~name:"Float.sech"
        (fun () -> ignore (sech f0));
      Bench.Test.create ~name:"Float.coth"
        (fun () -> ignore (coth f0));
      Bench.Test.create ~name:"Float.asinh"
        (fun () -> ignore (asinh f0));
      Bench.Test.create ~name:"Float.acosh"
        (fun () -> ignore (acosh f0));
      Bench.Test.create ~name:"Float.atanh"
        (fun () -> ignore (atanh f0));
      Bench.Test.create ~name:"Float.acsch"
        (fun () -> ignore (acsch f0));
      Bench.Test.create ~name:"Float.asech"
        (fun () -> ignore (asech f0));
      Bench.Test.create ~name:"Float.acoth"
        (fun () -> ignore (acoth f0));
      Bench.Test.create ~name:"Float.hypot"
        (fun () -> ignore (hypot f0 f1));
      Bench.Test.create ~name:"Float.ceil"
        (fun () -> ignore (ceil f0));
      Bench.Test.create ~name:"Float.floor"
        (fun () -> ignore (floor f0));
      Bench.Test.create ~name:"Float.abs_float"
        (fun () -> ignore (abs_float f0));
      Bench.Test.create ~name:"Float.copysign"
        (fun () -> ignore (copysign f0 f1));
      Bench.Test.create ~name:"Float.mod_float"
        (fun () -> ignore (mod_float f0 f1));
      Bench.Test.create ~name:"Float.frexp"
        (fun () -> ignore (frexp f0));
      Bench.Test.create ~name:"Float.ldexp"
        (fun () -> ignore (ldexp f0 i0));
      Bench.Test.create ~name:"Float.modf"
        (fun () -> ignore (modf f0));
      Bench.Test.create ~name:"Float.float_of_int"
        (fun () -> ignore (float_of_int i0));
      Bench.Test.create ~name:"Float.float"
        (fun () -> ignore (float i0));
      Bench.Test.create ~name:"Float.truncate"
        (fun () -> ignore (truncate f0));
      Bench.Test.create ~name:"Float.compare"
        (fun () -> ignore (compare f0 f1));
      Bench.Test.create ~name:"Float.min_float"
        (fun () -> ignore (min f0 f1));
      Bench.Test.create ~name:"Float.max_float"
        (fun () -> ignore (max f0 f1));
      Bench.Test.create ~name:"Float.int_of_float"
        (fun () -> ignore (int_of_float f0));
      Bench.Test.create ~name:"Float.valid_float_lexem"
        (fun () -> ignore (valid_float_lexem s0));
      Bench.Test.create ~name:"Float.string_of_float"
        (fun () -> ignore (string_of_float f0));
      Bench.Test.create ~name:"Float.float_of_string"
        (fun () -> ignore (float_of_string s0));
    ])
