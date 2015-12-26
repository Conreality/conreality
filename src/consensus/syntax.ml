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

module Token = struct
  #include "syntax/token.ml"
end

open Parser

let is_verb = function
  | ABORT | DISABLE | ENABLE | FIRE | HOLD | JOIN | LEAVE
  | PAN | PING | RESUME | TILT | TOGGLE | TRACK -> true
  | _ -> false

let is_keyword string =
  let keyword = String.lowercase string in
  Hashtbl.mem Lexer.keyword_table keyword

let keyword_to_token string =
  let keyword = String.lowercase string in
  Hashtbl.find Lexer.keyword_table keyword

let parse_from_lexbuf input =
  Parser.parse Lexer.lex input

let parse_from_channel input =
  Lexing.from_channel input |> parse_from_lexbuf

let parse_from_string input =
  Lexing.from_string input |> parse_from_lexbuf

let is_valid string =
  try (parse_from_string string |> ignore; true) with
  | Lexer.Error _ | Parser.Error -> false

let lexbuf_to_list lexbuf =
  let rec consume input output =
    match Lexer.lex input with
    | Parser.EOF -> output
    | token -> consume input (token :: output)
  in List.rev (consume lexbuf [])

let tokenize input =
  Lexing.from_string input |> lexbuf_to_list
