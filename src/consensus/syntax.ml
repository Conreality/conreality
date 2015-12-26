(* This is free and unencumbered software released into the public domain. *)

open Prelude

module Exception = struct
  #include "syntax/exception.ml"
end

exception Error = Exception.Error

module Command = struct
  #include "syntax/command.ml"
end

module Token = struct
  #include "syntax/token.ml"
end

module Lexer = struct
  #include "syntax/lexer.ml"
end

module Parser = struct
  #include "syntax/parser.ml"
end

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
  | Error _ | Parsing.Parse_error -> false

let lexbuf_to_list lexbuf =
  let rec consume input output =
    match Lexer.lex input with
    | Token.EOF -> output
    | token -> consume input (token :: output)
  in List.rev (consume lexbuf [])

let tokenize input =
  Lexing.from_string input |> lexbuf_to_list

let help_key_for input =
  let open Token in
  match tokenize input with
  | [] -> None
  | ABORT as k :: _   -> Some (Token.to_string k)
  | DISABLE as k :: _ -> Some (Token.to_string k)
  | ENABLE as k :: _  -> Some (Token.to_string k)
  | FIRE as k :: _    -> Some (Token.to_string k)
  | HOLD as k :: _    -> Some (Token.to_string k)
  | JOIN as k :: _    -> Some (Token.to_string k)
  | LEAVE as k :: _   -> Some (Token.to_string k)
  | PAN as k :: (TO as k' :: _)  ->
    Some (Printf.sprintf "%s %s" (Token.to_string k) (Token.to_string k'))
  | PAN as k :: _     -> Some (Token.to_string k)
  | PING as k :: _    -> Some (Token.to_string k)
  | RESUME as k :: _  -> Some (Token.to_string k)
  | TILT as k :: (TO as k' :: _) ->
    Some (Printf.sprintf "%s %s" (Token.to_string k) (Token.to_string k'))
  | TILT as k :: _    -> Some (Token.to_string k)
  | TOGGLE as k :: _  -> Some (Token.to_string k)
  | TRACK as k :: _   -> Some (Token.to_string k)
  | _  -> None

let help_for input =
  match help_key_for input with
  | Some key -> Some (Hashtbl.find (Command.help ()) key)
  | None -> None
