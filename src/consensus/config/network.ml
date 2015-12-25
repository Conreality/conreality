(* This is free and unencumbered software released into the public domain. *)

open Prelude
open Lua_api
open Lwt.Infix
open Scripting

module IRC = struct
  type t = {
    host:     string;
    port:     int;
    password: string;
    nick:     string;
    username: string;
    realname: string;
    channel:  string;
  }

  let required_keys = ["host"; "nick"; "channel"]

  let optional_keys = ["port"; "password"; "username"; "realname"]

  let create ?(host="") ?(port=0) ?(password="")
             ?(nick="") ?(username="") ?(realname="")
             ?(channel="") () =
    { host; port; password; nick; username; realname; channel; }

  let of_table table =
    let host     = Entry.required_string table "host" in
    let port     = Entry.optional_int    table "port" 6667 in
    let password = Entry.optional_string table "password" "" in
    let nick     = Entry.required_string table "nick" in
    let username = Entry.optional_string table "username" nick in
    let realname = Entry.optional_string table "realname" "" in
    let channel  = Entry.required_string table "channel" in
    create ~host ~port ~password ~nick ~username ~realname ~channel ()
end

module ROS = struct
  type t = Table.t

  let required_keys = []

  let optional_keys = []

  let create () = Table.create 0

  let of_table table = table
end

module STOMP = struct
  type t = Table.t

  let required_keys = []

  let optional_keys = []

  let create () = Table.create 0

  let of_table table = table
end

type t = {
  mutable irc:   IRC.t;
  mutable ros:   ROS.t;
  mutable stomp: STOMP.t;
}

let create () = {
  irc   = IRC.create ();
  ros   = ROS.create ();
  stomp = STOMP.create ();
}

let require_keys section table keys =
  List.iter
    (fun key ->
      if Hashtbl.mem table (Value.of_string key) then ()
      else Lwt_log.ign_error_f "Missing key \"%s\" in %s configuration." key section)
    keys

let load_irc_table context =
  let section = "network.irc" in
  let table = Context.pop_table context in
  require_keys section table IRC.required_keys;
  IRC.of_table table

let load_ros_table context =
  let section = "network.ros" in
  let table = Context.pop_table context in
  require_keys section table ROS.required_keys;
  ROS.of_table table

let load_stomp_table context =
  let section = "network.stomp" in
  let table = Context.pop_table context in
  require_keys section table STOMP.required_keys;
  STOMP.of_table table

let load network context =
  LuaL.checktype context (-1) Lua.LUA_TTABLE;
  Lua.getfield context (-1) "irc";
  network.irc <- load_irc_table context;
  Lua.getfield context (-1) "ros";
  network.ros <- load_ros_table context;
  Lua.getfield context (-1) "stomp";
  network.stomp <- load_stomp_table context
