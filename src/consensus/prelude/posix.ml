(* This is free and unencumbered software released into the public domain. *)

external ioctl_void : Unix.file_descr -> int64 -> int64 =
  "caml_conreality_ioctl_void"

external ioctl_int64_val : Unix.file_descr -> int64 -> int64 -> int64 =
  "caml_conreality_ioctl_int64_val"

external ioctl_int64_ref : Unix.file_descr -> int64 -> int64 -> int64 =
  "caml_conreality_ioctl_int64_ref"

external ioctl_bigarray : Unix.file_descr -> int64 -> Bigarray.int8_unsigned_elt -> int64 =
  "caml_conreality_ioctl_bigarray"

module Ioctl = struct
  type t =
    | None
    | Int_val   of int
    | Int_ref   of int
    | Int32_val of int32
    | Int32_ref of int32
    | Int64_val of int64
    | Int64_ref of int64
    | Bigarray  of Bigarray.int8_unsigned_elt
end

open Ioctl

let ioctl fd cmd = function
  | None          -> ioctl_void fd cmd
  | Int_val   arg -> ioctl_int64_val fd cmd (Int64.of_int arg)   (* FIXME? *)
  | Int_ref   arg -> ioctl_int64_ref fd cmd (Int64.of_int arg)   (* FIXME? *)
  | Int32_val arg -> ioctl_int64_val fd cmd (Int64.of_int32 arg) (* FIXME? *)
  | Int32_ref arg -> ioctl_int64_ref fd cmd (Int64.of_int32 arg) (* FIXME? *)
  | Int64_val arg -> ioctl_int64_val fd cmd arg
  | Int64_ref arg -> ioctl_int64_ref fd cmd arg
  | Bigarray  arg -> ioctl_bigarray fd cmd arg
