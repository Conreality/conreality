(* This is free and unencumbered software released into the public domain. *)

open Prelude

module Command = struct
  #include "syntax/command.ml"
end

module Parser = struct
  #include "syntax/parser.ml"
end

module Lexer = struct
  #include "syntax/lexer.ml"
end

let parse_from_lexbuf input =
  Parser.parse Lexer.lex input

let parse_from_channel input =
  Lexing.from_channel input |> parse_from_lexbuf

let parse_from_string input =
  Lexing.from_string input |> parse_from_lexbuf
