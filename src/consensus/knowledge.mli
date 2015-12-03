(* This is free and unencumbered software released into the public domain. *)

(** Knowledge base. *)

module Term : sig
  type t =
    | URI of string
    | UUID of string
    | Node of string
  val make_uri : string -> t
  val make_uuid : string -> t
  val make_node : string -> t
end

(* A fact is a propositional statement represented by a binary relation. *)
module Fact : sig
  type t
  val create : Term.t -> Term.t -> Term.t -> t
  val subject : t -> Term.t
  val predicate : t -> Term.t
  val object_ : t -> Term.t
  val confidence : t -> float option
  val compare : t -> t -> int
end

module Fact_set : sig
  type t
end

module Rule : sig
  type t
  val compare : t -> t -> int
end

module Rule_set : sig
  type t
end

module Store : sig
  type t
  val create : unit -> t
  val facts : t -> Fact_set.t
  val rules : t -> Rule_set.t
  val is_empty : t -> bool
  val has_fact : t -> Fact.t -> bool
  val has_rule : t -> Rule.t -> bool
  val insert : t -> Fact.t -> unit
  val remove : t -> Fact.t -> unit
end
