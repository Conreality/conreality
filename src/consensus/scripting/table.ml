(* This is free and unencumbered software released into the public domain. *)

open Prelude

type t = (Value.t, Value.t) Hashtbl.t

let create size : t = Hashtbl.create size

let size (table : t) = Hashtbl.length table

let clear (table : t) = Hashtbl.clear table

let reset (table : t) = Hashtbl.reset table

let remove (table : t) = Hashtbl.remove table

let insert (table : t) = Hashtbl.replace table

let iter (table : t) f = Hashtbl.iter f table
