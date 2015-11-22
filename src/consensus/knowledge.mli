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

(* A fact is a propositional statement represented by a binary relation. *)
module Fact : sig
  type t
  val create : Term.t -> Term.t -> Term.t -> t
  val subject : t -> Term.t
  val predicate : t -> Term.t
  val object_ : t -> Term.t
  val confidence : t -> float option
end

module Rule : sig
  type t
end
