(* This is free and unencumbered software released into the public domain. *)

open Lua_api
open Prelude

type t =
  | Nil
  | Boolean of bool
  | Integer of int
  | Number of float
  | String of string
  | Table of Table.t

let of_unit =
  Nil

let of_bool value =
  Boolean value

let of_int value =
  Integer value

let of_float value =
  Number value

let of_string value =
  String value

let of_table value =
  Table value

let to_type = function
  | Nil       -> Type.Nil
  | Boolean _ -> Type.Boolean
  | Integer _ -> Type.Integer
  | Number _  -> Type.Number
  | String _  -> Type.String
  | Table _   -> Type.Table

let to_string = function
  | Nil           -> "nil"
  | Boolean value -> Bool.to_string value
  | Integer value -> Int.to_string value
  | Number value  -> Float.string_of_float value
  | String value  -> value
  | Table value   -> begin
      assert false (* TODO *)
    end
