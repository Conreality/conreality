(* This is free and unencumbered software released into the public domain. *)

(** Messaging protocols. *)

module Topic : sig
  #include "messaging/topic.mli"
end

module IRC : sig
  #include "messaging/irc.mli"
end

module MQTT : sig
  #include "messaging/mqtt.mli"
end

module ROS : sig
  #include "messaging/ros.mli"
end

(* See: https://stomp.github.io/stomp-specification-1.2.html *)
module STOMP : sig
  #include "messaging/stomp.mli"
end
