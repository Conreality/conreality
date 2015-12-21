(* This is free and unencumbered software released into the public domain. *)

(** Surface syntax. *)

module Command : sig
  #include "syntax/command.mli"
end

module Parser : sig
  #include "syntax/parser.mli"
end

module Lexer : sig
  #include "syntax/lexer.inferred.mli"
end

val is_verb : Parser.token -> bool
val is_keyword : string -> bool
val keyword_to_token : string -> Parser.token
val parse_from_channel : in_channel -> Command.t
val parse_from_string : string -> Command.t
