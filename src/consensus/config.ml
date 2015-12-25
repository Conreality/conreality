(* This is free and unencumbered software released into the public domain. *)

open Prelude
open Scripting

module Devices = struct
  type t = unit

  let create () = () (* TODO *)

  let load devices context = () (* TODO *)
end

module Network = struct
  type t = {
    irc: Table.t;
    ros: Table.t;
    stomp: Table.t;
  }

  let create () = {
    irc   = Table.create 0;
    ros   = Table.create 0;
    stomp = Table.create 0;
  }

  let load network context = ()
end

type t = {
  devices: Devices.t;
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
