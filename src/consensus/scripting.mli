(* This is free and unencumbered software released into the public domain. *)

(** Scripting engine. *)

exception Input_error of string
exception Parse_error of string
exception Runtime_error of string

module Type : sig
  #include "scripting/type.mli"
end

module Value : sig
  #include "scripting/value.mli"
end

module Table : sig
  #include "scripting/table.mli"
end

module Context : sig
  #include "scripting/context.mli"
end
