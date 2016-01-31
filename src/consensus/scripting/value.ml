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

let rec inspect = function
  | Nil           -> "nil"
  | Boolean value -> Bool.to_string value
  | Integer value -> Int.to_string value
  | Number value  -> Float.string_of_float value
  | String value  -> begin
      "\"" ^ value ^ "\"" (* TODO: escaping of special characters *)
    end
  | Table value   -> begin
      let buffer = Buffer.create 0 in
      Buffer.add_char buffer '{';
      Hashtbl.iter
        (fun k v ->
          Buffer.add_string buffer
            (Printf.sprintf "%s=%s, " (inspect k) (inspect v)))
        value;
      Buffer.add_char buffer '}';
      Buffer.contents buffer
    end

let fail_conversion operation value =
  failwith (Printf.sprintf "Value.%s failed to convert %s" operation (inspect value))

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

let to_bool = function
  | Boolean value -> value
  | value -> fail_conversion "to_bool" value

let to_int = function
  | Integer value -> value
  | value -> fail_conversion "to_int" value

let to_float = function
  | Integer value -> Float.of_int value
  | Number value -> value
  | value -> fail_conversion "to_float" value

let to_string = function
  | Nil              -> ""
  | Boolean value    -> Bool.to_string value
  | Integer value    -> Int.to_string value
  | Number value     -> Float.string_of_float value
  | String value     -> value
  | Table _ as table -> inspect table (* developer representation *)

let to_table = function
  | Table value -> value
  | value -> fail_conversion "to_table" value
