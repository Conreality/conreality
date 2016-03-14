(* This is free and unencumbered software released into the public domain. *)

(* read addr offset return value read *)
external read: int32 -> int -> int32 = "caml_mmap32_read"

(* write addr offset data return unit *)
external write: int32 -> int -> int32 -> unit = "caml_mmap32_write"

(* mmap addr len return location of mapping *)
external mmap: int32 -> int -> int32  = "caml_mmap32_mmap"

(* fixme
       int munmap(void *addr, size_t length);
*)
