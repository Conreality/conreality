(* This is free and unencumbered software released into the public domain. *)

open Prelude
open Lua_api
open Lwt.Infix
open Scripting

type t = unit

let create () = () (* TODO *)

let load devices context =
  LuaL.checktype context (-1) Lua.LUA_TTABLE
  (* TODO *)
