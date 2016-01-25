(* This is free and unencumbered software released into the public domain. *)

open Prelude

module Message = struct
  include Irc_message
end

module Client = struct
  include Irc_client_lwt
end

module Connection = struct
  type t = Client.connection_t
end

module Callback = struct
  type t = Connection.t -> Message.parse_result -> unit Lwt.t
end
