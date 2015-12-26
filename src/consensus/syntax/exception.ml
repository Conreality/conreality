(* This is free and unencumbered software released into the public domain. *)

open Prelude

type t = Lexical | Syntactic | Semantic

exception Error of t * string

let lexical_error message =
  raise (Error (Lexical, message))

let syntactic_error message =
  raise (Error (Syntactic, message))

let semantic_error message =
  raise (Error (Semantic, message))
