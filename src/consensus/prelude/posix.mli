(* This is free and unencumbered software released into the public domain. *)

module Ioctl : sig
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

val ioctl : Unix.file_descr -> int64 -> Ioctl.t -> int64
