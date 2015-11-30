(* This is free and unencumbered software released into the public domain. *)

open Prelude

let objects = ref ([] : Object.t list)

let reset () =
  objects := []

let is_empty () =
  !objects = []

let label () : string option = None

let location () = Some Geometry.P3.zero (* TODO *)

let register (obj : Object.t) =
  objects := obj :: !objects

let unregister (obj : Object.t) =
  failwith "Not implemented as yet" (* TODO *)

let iter (f : (Object.t -> unit)) =
  List.iter f !objects
