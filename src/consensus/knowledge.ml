(* This is free and unencumbered software released into the public domain. *)

open Prelude

module Term = struct
  type t =
    | URI of string
    | UUID of string
    | Node of string

  let make_uri string = URI string

  let make_uuid string = UUID string

  let make_node label = Node label
end
