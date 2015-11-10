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

  let load_code context code =
    LuaL.loadstring context code |> ignore (* TODO: use thread_status *)

  let eval_code context filepath =
    load_code context filepath;
    match Lua.pcall context 0 0 0 with
    | Lua.LUA_OK -> ()
    | error -> begin
        let error_message = (Lua.tostring context (-1) |> Option.value_exn) in
        Lua.pop context 1;
        failwith error_message
      end

  let get_string context code =
    match LuaL.loadstring context ("_=" ^ code) with
    | Lua.LUA_OK -> begin
        match Lua.pcall context 0 0 0 with
        | Lua.LUA_OK -> begin
            Lua.getglobal context "_";
            let result = (Lua.tostring context (-1) |> Option.value_exn) in
            Lua.pop context 1;
            result
          end
        | _ -> failwith ("error executing: " ^ code)
      end
    | _ -> failwith ("error parsing: " ^ code)

end
