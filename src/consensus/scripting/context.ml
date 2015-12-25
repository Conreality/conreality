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

let push_nil = Lua.pushnil

let push_bool = Lua.pushboolean

let push_int = Lua.pushinteger

let push_float = Lua.pushnumber

let push_string = Lua.pushstring

let push_value context = function
  | Value.Nil -> push_nil context
  | Value.Boolean value -> push_bool context value
  | Value.Integer value -> push_int context value
  | Value.Number value -> push_float context value
  | Value.String value -> push_string context value

let get_bool context =
  Lua.toboolean context (-1)

let get_int context =
  Int.of_float (Lua.tonumber context (-1))

let get_float context =
  Lua.tonumber context (-1)

let get_string context =
  Lua.tostring context (-1) |> Option.value_exn

let get_value context =
  match (Lua.type_ context (-1)) with
  | Lua.LUA_TNIL -> Value.of_unit
  | Lua.LUA_TBOOLEAN -> Value.of_bool (get_bool context)
  | Lua.LUA_TNUMBER -> Value.of_float (get_float context)
  | Lua.LUA_TSTRING -> Value.of_string (get_string context)
  | Lua.LUA_TTABLE -> assert false (* TODO *)
  | _ -> assert false

let pop context =
  Lua.pop context 1

let pop_bool context =
  let result = get_bool context in pop context; result

let pop_int context =
  let result = get_int context in pop context; result

let pop_float context =
  let result = get_float context in pop context; result

let pop_string context =
  let result = get_string context in pop context; result

let pop_value context =
  let result = get_value context in pop context; result

let define context name callback =
  Lua.register context name callback

let undefine context name =
  push_nil context;
  Lua.setglobal context name

let call_tos context = (* not public *)
  match Lua.pcall context 0 0 0 with
  | Lua.LUA_OK -> ()
  | Lua.LUA_ERRRUN -> begin
      let error_message = (get_string context) in
      pop context;
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

let get_field_as_string context field =
  Lua.getfield context (-1) field;
  pop_string context
