(* This is free and unencumbered software released into the public domain. *)

(** Surface syntax. *)

module Parser : sig
  #include "syntax/parser.mli"
end

module Lexer : sig
  #include "syntax/lexer.inferred.mli"
end
