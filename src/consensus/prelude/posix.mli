(* This is free and unencumbered software released into the public domain. *)

module Ioctl : sig
  type t =
    | None
    | Int_in of int
    | Int32_in of int32
    | Int64_in of int64
end

val ioctl : Unix.file_descr -> int64 -> Ioctl.t -> int32
