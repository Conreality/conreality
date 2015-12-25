(* This is free and unencumbered software released into the public domain. *)

open Prelude

type t =
  | Nil
  | Boolean
  | Integer
  | Number
  | String
  | Table

let to_string = function
  | Nil     -> "nil"
  | Boolean -> "boolean"
  | Integer -> "integer"
  | Number  -> "number"
  | String  -> "string"
  | Table   -> "table"
