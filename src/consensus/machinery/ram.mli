(* This is free and unencumbered software released into the public domain. *)

#if OCAMLVERSION < 4020
type bytes = string
#endif

type addr = int64

(** Initializes access to physical memory. *)
val init : unit -> unit

(** Discontinues access to physical memory. *)
val close : unit -> unit

(** Enables access to a contiguous block of physical memory. *)
val access : addr -> int -> unit

(** Reads a contiguous block of bytes from physical memory. *)
val read : addr -> int -> bytes

(** Reads a single byte from physical memory. *)
val read_byte : addr -> char

(** Reads a single 32-bit word from physical memory. *)
val read_int32 : addr -> int32

(** Reads a single 64-bit word from physical memory. *)
val read_int64 : addr -> int64

(** Writes a contiguous block of bytes to physical memory. *)
val write : addr -> bytes -> int

(** Writes a single byte to physical memory. *)
val write_byte : addr -> char -> unit

(** Writes a single 32-bit word to physical memory. *)
val write_int32 : addr -> int32 -> unit

(** Writes a single 64-bit word to physical memory. *)
val write_int64 : addr -> int64 -> unit
