(* This is free and unencumbered software released into the public domain. *)

open Lua_api

module Option = struct
 let value_exn = function
 | Some value -> value
 | None -> raise Not_found
end

module Context = struct
  type t = Lua_api_lib.state

  let create () =
    let context = LuaL.newstate () in
    LuaL.openlibs context;
    context

  let load_file context filepath =
    LuaL.loadfile context filepath |> ignore (* TODO: use thread_status *)

  let eval_file context filepath =
    load_file context filepath;
    match Lua.pcall context 0 0 0 with
    | Lua.LUA_OK -> ()
    | error -> begin
        let error_message = (Lua.tostring context (-1) |> Option.value_exn) in
        Lua.pop context 1;
        failwith error_message
      end

end
