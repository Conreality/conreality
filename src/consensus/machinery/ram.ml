(* This is free and unencumbered software released into the public domain. *)

#if OCAMLVERSION < 4020
type bytes = string
#endif

open Prelude

type addr = int64

type opened = { fd: Unix.file_descr }

type state = opened option

let state = ref (None : state)

let init () =
  match !state with
  | Some _ -> () (* already initialized *)
  | _ -> begin
      let flags = [Unix.O_RDWR; Unix.O_SYNC] in
      let fd = Unix.openfile "/dev/mem" flags 0 in
      state := Some { fd }
    end

let close () =
  match !state with
  | None -> ()
  | Some { fd } -> begin
      Unix.close fd;
      state := None
    end

let read (addr : addr) length =
  assert (addr >= Int64.zero);
  assert (length >= 0);
  match !state with
  | None -> failwith "RAM.init not yet called"
  | Some { fd } -> begin
      (* TODO: optimize this using pread(2) to eliminate the seek. *)
      let _ = Unix.LargeFile.lseek fd addr Unix.SEEK_SET in
      let buffer = Bytes.make length '\x00' in
      let rc = Unix.read fd buffer 0 length in
      let _ = assert (rc = length) in
      buffer
    end

let read_byte (addr : addr) =
  Bytes.get (read addr 1) 0

let read_int32 (addr : addr) =
  (* FIXME: this assumes a little-endian architecture: *)
  let bytes = (read addr 4) in
  let byte0 = Char.to_int32 (Bytes.get bytes 0) in
  let byte1 = Char.to_int32 (Bytes.get bytes 1) in
  let byte2 = Char.to_int32 (Bytes.get bytes 2) in
  let byte3 = Char.to_int32 (Bytes.get bytes 3) in
  byte0 |>
  Int32.logor (Int32.shift_left byte1 0x08) |>
  Int32.logor (Int32.shift_left byte2 0x10) |>
  Int32.logor (Int32.shift_left byte3 0x18)

let read_int64 (addr : addr) =
  (* FIXME: this assumes a little-endian architecture: *)
  let bytes = (read addr 8) in
  let byte0 = Char.to_int64 (Bytes.get bytes 0) in
  let byte1 = Char.to_int64 (Bytes.get bytes 1) in
  let byte2 = Char.to_int64 (Bytes.get bytes 2) in
  let byte3 = Char.to_int64 (Bytes.get bytes 3) in
  let byte4 = Char.to_int64 (Bytes.get bytes 4) in
  let byte5 = Char.to_int64 (Bytes.get bytes 5) in
  let byte6 = Char.to_int64 (Bytes.get bytes 6) in
  let byte7 = Char.to_int64 (Bytes.get bytes 7) in
  byte0 |>
  Int64.logor (Int64.shift_left byte1 0x08) |>
  Int64.logor (Int64.shift_left byte2 0x10) |>
  Int64.logor (Int64.shift_left byte3 0x18) |>
  Int64.logor (Int64.shift_left byte4 0x20) |>
  Int64.logor (Int64.shift_left byte5 0x28) |>
  Int64.logor (Int64.shift_left byte6 0x30) |>
  Int64.logor (Int64.shift_left byte7 0x38)

let write (addr : addr) buffer =
  assert (addr >= Int64.zero);
  match !state with
  | None -> failwith "RAM.init not yet called"
  | Some { fd } -> begin
      (* TODO: optimize this using pwrite(2) to eliminate the seek. *)
      let _ = Unix.LargeFile.lseek fd addr Unix.SEEK_SET in
      let length = Bytes.length buffer in
      let rc = Unix.single_write fd buffer 0 length in
      let _ = assert (rc = length) in
      length
    end

let write_byte (addr : addr) byte =
  write addr (Bytes.make 1 byte) |> ignore

let write_int32 (addr : addr) (word : int32) =
  () (* TODO *)

let write_int64 (addr : addr) (word : int64) =
  () (* TODO *)
