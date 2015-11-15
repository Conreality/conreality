(* This is free and unencumbered software released into the public domain. *)

open Ctypes
open Foreign
open Prelude

let hello =
  foreign "hello" (void @-> returning void)
