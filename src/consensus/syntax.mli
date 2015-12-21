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

val parse_from_channel : in_channel -> Command.t
val parse_from_string : string -> Command.t
