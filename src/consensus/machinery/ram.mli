(* This is free and unencumbered software released into the public domain. *)

#if OCAMLVERSION < 4020
type bytes = string
#endif

type addr = int64

(** Initializes access to physical memory. *)
val init : unit -> unit

(** Discontinues access to physical memory. *)
val close : unit -> unit

(** Reads a contiguous block of bytes from physical memory. *)
val read : addr -> int -> bytes

(** Reads a single byte from physical memory. *)
val read_byte : addr -> char
