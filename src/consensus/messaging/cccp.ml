(* This is free and unencumbered software released into the public domain. *)

open Prelude
open Lwt.Infix
open Networking
open Syntax

module Protocol = struct
  let port = 1984
end

module Client = struct
  type t = Lwt_unix.sockaddr

  let any =
    Unix.(ADDR_INET (Unix.inet_addr_any, 0))

  let compare (a : t) (b : t) =
    Pervasives.compare a b

  let to_string = function
    | Unix.ADDR_INET (addr, port) ->
      Printf.sprintf "%s:%d" (Unix.string_of_inet_addr addr) port
    | Unix.ADDR_UNIX _ -> assert false
end

module Callback = struct
  type t = Client.t -> string -> unit
end

module Server = struct
  type t = {
    socket: UDP.Socket.t;
    buffer: Lwt_bytes.t;
  }

  let create socket =
    { socket; buffer = UDP.Packet.make_buffer (); }

  let socket { socket; _ } = socket

  let buffer { buffer; _ } = buffer

  let rec loop server (callback : Callback.t) =
    let { socket; buffer } = server in
    UDP.Socket.recvfrom socket buffer >>= fun (length, client) ->
    let command = String.sub (Lwt_bytes.to_string buffer) 0 length in
    Lwt_log.ign_notice_f "Received %d bytes from %s: %s" length (Client.to_string client) command;
    callback client (if (String.length command) > 1 then command else "") |> ignore; (* for `nc` probe packets *)
    loop server callback
end
