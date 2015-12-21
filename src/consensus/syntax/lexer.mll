(* This is free and unencumbered software released into the public domain. *)

{
  open Parser
  exception Error of string

  let keyword_table =
    let table = Hashtbl.create 20 in
    let define kwd tok = Hashtbl.add table kwd tok in
    (* Command verbs: *)
    define "abort"    ABORT;
    define "disable"  DISABLE;
    define "enable"   ENABLE;
    define "fire"     FIRE;
    define "hold"     HOLD;
    define "join"     JOIN;
    define "leave"    LEAVE;
    define "pan"      PAN;
    define "ping"     PING;
    define "resume"   RESUME;
    define "tilt"     TILT;
    define "toggle"   TOGGLE;
    define "track"    TRACK;
    (* Command aliases: *)
    define "continue" RESUME;
    define "start"    ENABLE;
    define "stop"     DISABLE;
    (* Rotation directions: *)
    define "down"     DOWN;
    define "left"     LEFT;
    define "right"    RIGHT;
    define "up"       UP;
    table
}

rule lex = parse
  | [' ' '\t' '\n']
    { lex lexbuf } (* skip whitespace *)

  | ['0'-'9']+ as n
    { INTEGER (int_of_string n) }

  | ['A'-'Z' 'a'-'z' '_']['0'-'9' 'A'-'Z' 'a'-'z' '_' '-']* as s
    { try Hashtbl.find keyword_table s with Not_found -> SYMBOL (s) }

  | eof
    { EOF }

  | _
    { raise (Error (Printf.sprintf "unexpected character at offset %d" (Lexing.lexeme_start lexbuf))) }
