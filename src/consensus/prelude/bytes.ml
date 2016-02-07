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

let of_int32 value =
  let byte_at_index i =
    Char.zero (* TODO *)
  in
  init 4 byte_at_index

let of_int64 value =
  let byte_at_index i =
    Char.zero (* TODO *)
  in
  init 8 byte_at_index

let to_int32 bytes =
  assert ((length bytes) = 4);
  (* FIXME: this assumes a little-endian architecture: *)
  let byte0 = Char.to_int32 (get bytes 0) in
  let byte1 = Char.to_int32 (get bytes 1) in
  let byte2 = Char.to_int32 (get bytes 2) in
  let byte3 = Char.to_int32 (get bytes 3) in
  let open Int32 in
  byte0 |>
  logor (shift_left byte1 0x08) |>
  logor (shift_left byte2 0x10) |>
  logor (shift_left byte3 0x18)

let to_int64 bytes =
  assert ((length bytes) = 8);
  (* FIXME: this assumes a little-endian architecture: *)
  let byte0 = Char.to_int64 (get bytes 0) in
  let byte1 = Char.to_int64 (get bytes 1) in
  let byte2 = Char.to_int64 (get bytes 2) in
  let byte3 = Char.to_int64 (get bytes 3) in
  let byte4 = Char.to_int64 (get bytes 4) in
  let byte5 = Char.to_int64 (get bytes 5) in
  let byte6 = Char.to_int64 (get bytes 6) in
  let byte7 = Char.to_int64 (get bytes 7) in
  let open Int64 in
  byte0 |>
  logor (shift_left byte1 0x08) |>
  logor (shift_left byte2 0x10) |>
  logor (shift_left byte3 0x18) |>
  logor (shift_left byte4 0x20) |>
  logor (shift_left byte5 0x28) |>
  logor (shift_left byte6 0x30) |>
  logor (shift_left byte7 0x38)
