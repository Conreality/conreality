(* This is free and unencumbered software released into the public domain. *)

{
  open Parser
  exception Error of string
}

rule lex = parse
  | [' ' '\t' '\n'] { lex lexbuf }
  | ['0'-'9']+ as n { INTEGER (int_of_string n) }
  | eof             { EOF }
  | _ { raise (Error (Printf.sprintf "unexpected character at offset %d" (Lexing.lexeme_start lexbuf))) }
