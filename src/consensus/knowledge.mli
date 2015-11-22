(* This is free and unencumbered software released into the public domain. *)

module Term : sig
  type t =
    | URI of string
    | UUID of string
    | Node of string
  val make_uri : string -> t
  val make_uuid : string -> t
  val make_node : string -> t
end
