(* This is free and unencumbered software released into the public domain. *)

(** Surface syntax. *)

module Exception : sig
  #include "syntax/exception.mli"
end

exception Error of Exception.t * string

module Command : sig
  #include "syntax/command.mli"
end

module Token : sig
  #include "syntax/token.inferred.mli"
end

val is_keyword : string -> bool
val is_valid : string -> bool
val keyword_to_token : string -> Token.t
val parse_from_channel : in_channel -> Command.t
val parse_from_string : string -> Command.t
val tokenize : string -> Token.t list
val help_for : string -> string option
