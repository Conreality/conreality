(* This is free and unencumbered software released into the public domain. *)

open Prelude

exception Input_error of string
exception Parse_error of string
exception Runtime_error of string

module rec Type : sig
  #include "scripting/type.mli"
end = struct
  #include "scripting/type.ml"
end

and Value : sig
  #include "scripting/value.mli"
end = struct
  #include "scripting/value.ml"
end

and Table : sig
  #include "scripting/table.mli"
end = struct
  #include "scripting/table.ml"
end

module Context = struct
  #include "scripting/context.ml"
end
