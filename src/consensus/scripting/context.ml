(* This is free and unencumbered software released into the public domain. *)

open Lua_api
open Prelude

module Option = struct
 let value_exn = function
 | Some value -> value
 | None -> raise Not_found
end

type t = Lua_api_lib.state

let create () =
  let context = LuaL.newstate () in
  LuaL.openlibs context;
  context

let define context name callback =
  Lua.register context name callback

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

let push_value context = function
  | Value.Nil -> Lua.pushnil context
  | Value.Boolean value -> Lua.pushboolean context value
  | Value.Number value -> Lua.pushnumber context value
  | Value.String value -> Lua.pushstring context value

let get_value context =
  match (Lua.type_ context (-1)) with
  | Lua.LUA_TNIL -> Value.of_unit
  | Lua.LUA_TBOOLEAN -> Value.of_bool (Lua.toboolean context (-1))
  | Lua.LUA_TNUMBER -> Value.of_float (Lua.tonumber context (-1))
  | Lua.LUA_TSTRING -> Value.of_string (Lua.tostring context (-1) |> Option.value_exn)
  | Lua.LUA_TTABLE -> assert false (* TODO *)
  | _ -> assert false

let pop_value context =
  let result = get_value context in
  Lua.pop context 1;
  result

let pop_string context =
  let result = (Lua.tostring context (-1) |> Option.value_exn) in
  Lua.pop context 1;
  result

let get_field_as_string context field =
  Lua.getfield context (-1) field;
  pop_string context

let get_string context code =
  load_code context ("_=(" ^ code ^ ")"); (* TODO: use "return ..." instead? *)
  call_tos context;
  Lua.getglobal context "_";
  pop_string context
