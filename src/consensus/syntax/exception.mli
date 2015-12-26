(* This is free and unencumbered software released into the public domain. *)

type t = Lexical | Syntactic | Semantic

exception Error of t * string

val lexical_error : string -> 'a
val syntactic_error : string -> 'a
val semantic_error : string -> 'a
