(* This is free and unencumbered software released into the public domain. *)

external ioctl : Unix.file_descr -> int64 -> int32 = "caml_conreality_ioctl"
