(* This is free and unencumbered software released into the public domain. *)

open Prelude

module Parser = struct
  #include "syntax/parser.ml"
end

module Lexer = struct
  #include "syntax/lexer.ml"
end
