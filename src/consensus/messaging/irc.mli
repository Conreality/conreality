(* This is free and unencumbered software released into the public domain. *)

module Message = Irc_message

module Connection : sig
  type t = Irc_client_lwt.connection_t
end

module Client = Irc_client_lwt

module Callback : sig
  type t = Connection.t -> Message.parse_result -> unit Lwt.t
end
