(* This is free and unencumbered software released into the public domain. *)

open Ctypes
open Foreign

let hello =
  foreign "hello" (void @-> returning void)
