(* This is free and unencumbered software released into the public domain. *)

open Prelude
open Lua_api
open Lwt.Infix
open Messaging
open Scripting

let require_keys section table keys =
  List.iter
    (fun key ->
      if Hashtbl.mem table (Value.of_string key) then ()
      else Lwt_log.ign_error_f "Missing configuration key %s.%s." section key)
    keys

module Section = struct
  let load context section (create : unit -> 'a) (of_table : Table.t -> 'a) : 'a =
    match Context.pop_value context with
    | Value.Nil -> create ()
    | Value.Table table -> of_table table
    | _ -> begin
      Lwt_log.ign_error_f "Skipped invalid %s configuration." section;
      create ()
    end
end

module IRC = struct
  let section = "network.irc"

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
    require_keys section table required_keys;
    let host     = Entry.required_string table "host" in
    let port     = Entry.optional_int    table "port" 6667 in
    let password = Entry.optional_string table "password" "" in
    let nick     = Entry.required_string table "nick" in
    let username = Entry.optional_string table "username" nick in
    let realname = Entry.optional_string table "realname" "" in
    let channel  = Entry.required_string table "channel" in
    create ~host ~port ~password ~nick ~username ~realname ~channel ()

  let load context =
    Lua.getfield context (-1) "irc";
    Section.load context section create of_table

  let is_configured (config : t) =
    not (String.is_empty config.host) &&
    not (String.is_empty config.nick) &&
    not (String.is_empty config.channel)

  let connect { host; port; password; nick; username; realname; channel; } callback =
    let irc_url = Printf.sprintf "irc://%s:%d/%s" host port channel in
    Lwt_log.info_f "Connecting to %s..." irc_url
    >>= fun () -> Lwt_unix.gethostbyname host
    >>= fun hostent -> Lwt.return ()
    >>= fun () -> begin
      IRC.Client.connect ~addr:(hostent.Lwt_unix.h_addr_list.(0))
        ~port ~password ~nick ~username ~realname ~mode:0 ()
    end
    >>= fun connection -> Lwt.return ()
    >>= fun () -> Lwt_log.notice_f "Connected to %s." irc_url
    >>= fun () -> IRC.Client.send_join ~connection ~channel
    >>= fun () -> IRC.Client.listen ~connection ~callback (* event loop *)
    >>= fun () -> Lwt_log.info_f "Disconnecting from %s..." irc_url
    >>= fun () -> IRC.Client.send_quit ~connection
    >>= fun () -> Lwt_log.info_f "Disconnected from %s." irc_url
    >>= fun () -> Lwt.return connection
end

module ROS = struct
  let section = "network.ros"

  type t = Table.t

  let required_keys = []

  let optional_keys = []

  let create () = Table.create 0

  let of_table table =
    require_keys section table required_keys;
    table

  let load context =
    Lua.getfield context (-1) "ros";
    Section.load context section create of_table

  let is_configured (config : t) =
    false

  let connect (config : t) =
    Lwt.return () (* TODO *)
end

module STOMP = struct
  let section = "network.stomp"

  type t = Table.t

  let required_keys = []

  let optional_keys = []

  let create () = Table.create 0

  let of_table table =
    require_keys section table required_keys;
    table

  let load context =
    Lua.getfield context (-1) "stomp";
    Section.load context section create of_table

  let is_configured (config : t) =
    false

  let connect (config : t) =
    Lwt.return () (* TODO *)
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

let load network context =
  LuaL.checktype context (-1) Lua.LUA_TTABLE;
  network.irc   <- IRC.load context;
  network.ros   <- ROS.load context;
  network.stomp <- STOMP.load context