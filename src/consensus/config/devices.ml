(* This is free and unencumbered software released into the public domain. *)

open Prelude
open Lua_api
open Lwt.Infix
open Machinery
open Scripting

type t = {
  classes:   (string, unit) Hashtbl.t; (* FIXME: figure out the hashtbl value *)
  instances: (string, Device.t) Hashtbl.t;
}

let create () = {
  classes   = Hashtbl.create 0;
  instances = Hashtbl.create 0;
}

let is_registered devices name =
  Hashtbl.mem devices.instances name

let register devices name config =
  Lwt_log.ign_info_f "Registering the device /%s..." name;
  let driver_name = Value.to_string (Table.lookup config (Value.of_string "driver")) in
  let driver = Driver.find driver_name in
  let device = driver.constructor config in
  Hashtbl.replace devices.instances name device;
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
