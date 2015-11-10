(* This is free and unencumbered software released into the public domain. *)

open Lua_api

module Context = struct
  type t = Lua_api_lib.state

  let create () =
    LuaL.newstate ()

  let load_file context filepath =
    ()
end
