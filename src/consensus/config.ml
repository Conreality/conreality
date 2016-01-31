(* This is free and unencumbered software released into the public domain. *)

open Prelude
open Lua_api
open Lwt.Infix
open Scripting

module Entry = struct
  let required_string table key =
    Value.to_string (Table.lookup table (Value.of_string key))

  let optional_string table key default =
    Value.to_string (Table.lookup table (Value.of_string key))

  let optional_int table key default =
    match (Table.lookup table (Value.of_string key)) with
    | Value.Integer value -> value
    | Value.Number value -> Int.of_float value
    | Value.String value -> Int.of_string value
    | _ -> assert false
end

module Devices = struct
  #include "config/devices.ml"
end

module Network = struct
  #include "config/network.ml"
end

type 'a t = {
  devices: 'a Devices.t;
  network: Network.t;
}

let create () =
  {
    devices = Devices.create ();
    network = Network.create ();
  }

let load_file pathname =
  let config = create () in
  let context = Scripting.Context.create () in
  Scripting.Context.define context "devices"
    (fun context ->
      Devices.load config.devices context |> ignore; 0);
  Scripting.Context.define context "network"
    (fun context ->
      Network.load config.network context |> ignore; 0);
  Scripting.Context.eval_file context pathname;
  config
