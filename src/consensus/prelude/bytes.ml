(* This is free and unencumbered software released into the public domain. *)

#if OCAMLVERSION < 4020
type bytes = string
#endif

#if OCAMLVERSION < 4020
include String
#else
include Bytes
#endif

#if OCAMLVERSION < 4020
let empty = ""
#endif

#if OCAMLVERSION < 4020
let of_string = String.copy
#endif

#if OCAMLVERSION < 4020
let to_string = String.copy
#endif

#if OCAMLVERSION < 4020
let sub_string = sub
#endif

#if OCAMLVERSION < 4020
let extend (s : bytes) (left : int) (right : int) =
  failwith "not implemented for OCaml 4.01.0" (* TODO *)
#endif

#if OCAMLVERSION < 4020
let blit_string = blit
#endif

#if OCAMLVERSION < 4020
let cat s1 s2 = s1 ^ s2
#endif

let is_empty bytes = (length bytes) = 0

let of_bool value =
  of_string (Pervasives.string_of_bool value) (*BISECT-IGNORE*)

let of_float value =
  of_string (Pervasives.string_of_float value) (*BISECT-IGNORE*)

let of_int value =
  of_string (Pervasives.string_of_int value) (*BISECT-IGNORE*)
