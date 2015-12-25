(* This is free and unencumbered software released into the public domain. *)

module IRC : sig
  type t
  val is_configured : t -> bool
  val connect : t -> Irc_client_lwt.connection_t Lwt.t
end

module ROS : sig
  type t
  val is_configured : t -> bool
end

module STOMP : sig
  type t
  val is_configured : t -> bool
end

type t = {
  mutable irc:   IRC.t;
  mutable ros:   ROS.t;
  mutable stomp: STOMP.t;
}
