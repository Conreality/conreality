(* This is free and unencumbered software released into the public domain. *)

exception Input_error of string
exception Parse_error of string
exception Runtime_error of string

module Context : sig
  #include "scripting/context.mli"
end
