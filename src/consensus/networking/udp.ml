(* This is free and unencumbered software released into the public domain. *)

open Prelude
open Lwt.Infix

module Socket = struct
  type t = Lwt_unix.file_descr

  let bind addr port =
    let getproto name = (Unix.getprotobyname name).Unix.p_proto in
    let sockaddr addr port = Lwt_unix.(ADDR_INET (Unix.inet_addr_of_string addr, port)) in
    let socket = Lwt_unix.socket Unix.PF_INET Unix.SOCK_DGRAM (getproto "udp") in
    Lwt_unix.setsockopt socket Unix.SO_REUSEADDR true;
    Lwt_unix.bind socket (sockaddr addr port);
    socket

  let recvfrom socket buffer =
    Lwt_bytes.recvfrom socket buffer 0 (Lwt_bytes.length buffer) []
end

module Packet = struct
  let max_data_size = 64 * 1024 (* rounded up from 65,507 *)
end
