(* This is free and unencumbered software released into the public domain. *)

open Consensus.Prelude

let float =
  let module M = struct
    open Consensus.Prelude.Float
    type t = float
    let equal a b = a =. b
    let pp = Format.pp_print_float
  end in
  (module M: Alcotest.TESTABLE with type t = M.t)

let todo () = Alcotest.(check bool) "PASS" true true

let same_float a b = Alcotest.(check float) "same float" a b
let same_bool a b = Alcotest.(check bool) "same bool" a b
let same_int a b = Alcotest.(check int) "same int" a b
let same_string a b = Alcotest.(check string) "same string" a b
(* TODO: Genericize this, if possible *)
let same_float_list a b = Alcotest.(check (list float)) "same float list" a b
