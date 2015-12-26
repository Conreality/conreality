(* This is free and unencumbered software released into the public domain. *)

open Prelude

module Message = Irc_message

module Connection = struct
  type t = Irc_client_lwt.connection_t
end

module Client = Irc_client_lwt
