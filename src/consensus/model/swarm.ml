(* This is free and unencumbered software released into the public domain. *)

open Prelude

class virtual interface = object (self)
  method network : Network.t =
    failwith "Not implemented as yet" (* TODO *)

  (* TODO *)
end

type t = interface
