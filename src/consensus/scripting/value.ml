(* This is free and unencumbered software released into the public domain. *)

open Lua_api
open Prelude

type t =
  | Nil
  | Boolean of bool
  | Number of float
  | String of string
