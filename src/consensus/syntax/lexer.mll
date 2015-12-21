(* This is free and unencumbered software released into the public domain. *)

{
  open Parser
  exception Error of string
}

rule token = parse
  | [' ' '\t' '\n'] { token lexbuf }
  | ['0'-'9']+ as n { INTEGER (int_of_string n) }
  | eof             { EOF }
  | _ { raise (Error (Printf.sprintf "At offset %d: unexpected character.\n" (Lexing.lexeme_start lexbuf))) }
