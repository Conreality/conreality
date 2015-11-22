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

  let compare fact1 fact2 = -1 (* TODO *)
end

module Fact_set = Set.Make(Fact)

module Rule = struct
  type t = Fact.t (* TODO *)

  let compare rule1 rule2 = -1 (* TODO *)
end

module Rule_set = Set.Make(Rule)

module Store = struct
  type t = { mutable facts: Fact_set.t; mutable rules: Rule_set.t }

  let create () =
    {facts = Fact_set.empty; rules = Rule_set.empty}

  let facts store = store.facts
  let rules store = store.rules

  let is_empty store =
    Fact_set.is_empty store.facts &&
    Rule_set.is_empty store.rules

  let has_fact store fact =
    Fact_set.mem fact store.facts

  let has_rule store rule =
    Rule_set.mem rule store.rules

  let insert store fact =
    store.facts <- Fact_set.add fact store.facts

  let remove store fact =
    store.facts <- Fact_set.remove fact store.facts
end
