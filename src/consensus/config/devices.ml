(* This is free and unencumbered software released into the public domain. *)

open Prelude
open Lua_api
open Lwt.Infix
open Scripting

type t = {
  classes:   (string, unit) Hashtbl.t;
  instances: (string, unit) Hashtbl.t;
}

let create () = {
  classes   = Hashtbl.create 0;
  instances = Hashtbl.create 0;
}

let is_registered devices name =
  Hashtbl.mem devices.instances name

let register devices name config =
  Hashtbl.replace devices.instances name (); (* TODO *)
  Lwt_log.ign_notice_f "Registered the device /%s." name

let unregister devices name =
  Hashtbl.remove devices.instances name;
  Lwt_log.ign_notice_f "Unregistered the device /%s." name

let load devices context =
  let table = Context.pop_table context in
  Table.iter table
    (fun k v -> match (k, v) with
     | (Value.String name, Value.Table config) ->
       register devices name config
     | _ ->
       Lwt_log.ign_error_f "Skipped invalid %s configuration key: %s"
         "devices" (Value.to_string k))
