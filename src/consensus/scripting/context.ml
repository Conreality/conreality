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

let rec push_table context table =
  Lua.newtable context;
  Table.iter table
    (fun k v ->
      push_value context k;
      push_value context v;
      Lua.settable context (-3) |> ignore)

and push_value context = function
  | Value.Nil           -> push_nil context
  | Value.Boolean value -> push_bool context value
  | Value.Integer value -> push_int context value
  | Value.Number value  -> push_float context value
  | Value.String value  -> push_string context value
  | Value.Table value   -> push_table context value

let get_type context =
  match (Lua.type_ context (-1)) with
  | Lua.LUA_TNONE          -> assert false
  | Lua.LUA_TNIL           -> Type.Nil
  | Lua.LUA_TBOOLEAN       -> Type.Boolean
  | Lua.LUA_TLIGHTUSERDATA -> assert false
  | Lua.LUA_TNUMBER        -> Type.Number
  | Lua.LUA_TSTRING        -> Type.String
  | Lua.LUA_TTABLE         -> Type.Table
  | Lua.LUA_TFUNCTION      -> assert false
  | Lua.LUA_TUSERDATA      -> assert false
  | Lua.LUA_TTHREAD        -> assert false

let get_bool context =
  Lua.toboolean context (-1)

let get_int context =
  LuaL.checkint context (-1)

let get_float context =
  LuaL.checknumber context (-1)

let get_string context =
  LuaL.checkstring context (-1)

let rec get_table context =
  LuaL.checktype context (-1) Lua.LUA_TTABLE;
  let pop context = Lua.pop context 1 in
  let pop_value context =
    let result = get_value context in pop context; result
  in
  let table = Table.create 0 in
  push_nil context;
  while (Lua.next context (-2)) <> 0 do
    let v = pop_value context in
    let k = get_value context in
    Table.insert table k v
  done;
  table

and get_value context =
  match (get_type context) with
  | Type.Nil     -> Value.of_unit
  | Type.Boolean -> Value.of_bool (get_bool context)
  | Type.Integer -> Value.of_int (Int.of_string (get_string context)) (* Lua 5.2+ *)
  | Type.Number  -> begin
      let number = get_float context in
      let number_as_int = Float.truncate number in
      let number_as_float = Float.of_int number_as_int in
      if (Float.(=.) number number_as_float)
        then Value.of_int number_as_int
        else Value.of_float number
    end
  | Type.String  -> Value.of_string (get_string context)
  | Type.Table   -> Value.of_table (get_table context)

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

let pop_table context =
  let result = get_table context in pop context; result

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

let eval_as_value context code =
  eval_code context code;
  pop_value context

let get_field_as_string context field =
  Lua.getfield context (-1) field;
  pop_string context
