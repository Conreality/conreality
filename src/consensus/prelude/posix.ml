(* This is free and unencumbered software released into the public domain. *)

external ioctl_void : Unix.file_descr -> int64 -> int32 =
  "caml_conreality_ioctl_void"

external ioctl_int64 : Unix.file_descr -> int64 -> int64 -> int32 =
  "caml_conreality_ioctl_int64"

module Ioctl = struct
  type t =
    | None
    | Int_in of int
    | Int32_in of int32
    | Int64_in of int64
end

open Ioctl

let ioctl fd cmd = function
  | None         -> ioctl_void fd cmd
  | Int_in arg   -> ioctl_int64 fd cmd (Int64.of_int arg)
  | Int32_in arg -> ioctl_int64 fd cmd (Int64.of_int32 arg)
  | Int64_in arg -> ioctl_int64 fd cmd arg
