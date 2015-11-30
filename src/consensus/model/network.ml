(* This is free and unencumbered software released into the public domain. *)

open Prelude

class virtual interface = object (self)
  (* TODO *)
end

type t = interface

let compare a b =
  Pervasives.compare (Oo.id a) (Oo.id b)
