(* This is free and unencumbered software released into the public domain. *)

open Prelude

exception Input_error of string
exception Parse_error of string
exception Runtime_error of string

module Value = struct
  #include "scripting/value.ml"
end

module Context = struct
  #include "scripting/context.ml"
end
