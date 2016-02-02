(* This is free and unencumbered software released into the public domain. *)

open Prelude

type t = (Value.t, Value.t) Hashtbl.t

let create size : t = Hashtbl.create size

let size (table : t) = Hashtbl.length table

let clear (table : t) = Hashtbl.clear table

let reset (table : t) = Hashtbl.reset table

let remove (table : t) = Hashtbl.remove table

let insert (table : t) = Hashtbl.replace table

let lookup (table : t) = Hashtbl.find table

let lookup_int (table : t) key =
  try begin
    let value = Hashtbl.find table (Value.of_string key) in
    Some (Value.to_int value)
  end
  with Not_found -> None

let lookup_string (table : t) key =
  try begin
    let value = Hashtbl.find table (Value.of_string key) in
    Some (Value.to_string value)
  end
  with Not_found -> None

let iter (table : t) f = Hashtbl.iter f table
