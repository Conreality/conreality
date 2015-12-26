(* This is free and unencumbered software released into the public domain. *)

(** Surface syntax. *)

module Exception : sig
  #include "syntax/exception.mli"
end

exception Error of Exception.t * string

module Command : sig
  #include "syntax/command.mli"
end

module Parser : sig
  #include "syntax/parser.mli"
end

module Lexer : sig
  #include "syntax/lexer.inferred.mli"
end

module Token : sig
  #include "syntax/token.mli"
end

val is_keyword : string -> bool
val is_valid : string -> bool
val keyword_to_token : string -> Parser.token
val parse_from_channel : in_channel -> Command.t
val parse_from_string : string -> Command.t
val tokenize : string -> Parser.token list
val help_for : string -> string option
