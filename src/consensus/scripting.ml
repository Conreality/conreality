(* This is free and unencumbered software released into the public domain. *)

open Lua_api
open Prelude

module Option = struct
 let value_exn = function
 | Some value -> value
 | None -> raise Not_found
end

exception Input_error of string
exception Parse_error of string
exception Runtime_error of string

module Context = struct
  type t = Lua_api_lib.state

  let create () =
    let context = LuaL.newstate () in
    LuaL.openlibs context;
    context

  let call_tos context = (* not public *)
    match Lua.pcall context 0 0 0 with
    | Lua.LUA_OK -> ()
    | Lua.LUA_ERRRUN -> begin
        let error_message = (Lua.tostring context (-1) |> Option.value_exn) in
        Lua.pop context 1;
        raise (Runtime_error error_message)
      end
    | Lua.LUA_ERRMEM -> raise Out_of_memory
    | _ -> assert false

  let load_code context code =
    match LuaL.loadstring context code with
    | Lua.LUA_OK -> ()
    | Lua.LUA_ERRSYNTAX -> raise (Parse_error code)
    | Lua.LUA_ERRMEM -> raise Out_of_memory
    | _ -> assert false

  let load_file context filepath =
    match LuaL.loadfile context filepath with
    | Lua.LUA_OK -> ()
    | Lua.LUA_ERRSYNTAX -> raise (Parse_error filepath)
    | Lua.LUA_ERRMEM -> raise Out_of_memory
    (*| Lua.LUA_ERRFILE -> raise (Input_error filepath)*)
    | _ -> assert false

  let eval_code context code =
    load_code context code;
    call_tos context

  let eval_file context filepath =
    load_file context filepath;
    call_tos context

  let get_string context code =
    load_code context ("_=(" ^ code ^ ")");
    call_tos context;
    Lua.getglobal context "_";
    let result = (Lua.tostring context (-1) |> Option.value_exn) in
    Lua.pop context 1;
    result

end
