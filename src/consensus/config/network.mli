(* This is free and unencumbered software released into the public domain. *)

module CCCP : sig
  type t
  val is_configured : t -> bool
  val listen : t -> unit Lwt.t
end

module IRC : sig
  type t
  val is_configured : t -> bool
  val connect : t -> Messaging.IRC.Callback.t -> Messaging.IRC.Connection.t Lwt.t
end

module ROS : sig
  type t
  val is_configured : t -> bool
  val connect : t -> unit Lwt.t
end

module STOMP : sig
  type t
  val is_configured : t -> bool
  val connect : t -> unit Lwt.t
end

type t = {
  mutable cccp:  CCCP.t;
  mutable irc:   IRC.t;
  mutable ros:   ROS.t;
  mutable stomp: STOMP.t;
}
