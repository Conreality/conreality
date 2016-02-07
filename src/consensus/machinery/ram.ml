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
