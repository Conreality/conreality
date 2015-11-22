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

module Fact = struct
  type t = { s: Term.t; p: Term.t; o: Term.t; c: float option }

  let create s p o =
    {s = s; p = p; o = o; c = None}

  let subject fact = fact.s
  let predicate fact = fact.p
  let object_ fact = fact.o
  let confidence fact = fact.c
end

module Rule = struct
  type t = Fact.t (* TODO *)
end
