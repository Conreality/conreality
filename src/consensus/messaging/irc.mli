(* This is free and unencumbered software released into the public domain. *)

module Message : sig
  include module type of struct include Irc_message end
end

module Client : sig
  include module type of struct include Irc_client_lwt end
end

module Connection : sig
  type t = Client.connection_t
end

module Callback : sig
  type t = Connection.t -> Message.parse_result -> unit Lwt.t
end
