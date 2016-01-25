(* This is free and unencumbered software released into the public domain. *)

(** Messaging protocols. *)

module Topic : sig
  #include "messaging/topic.mli"
end

(** Consensus Command and Control Protocol (CCCP). *)
(* See: http://api.conreality.org/protocols/cccp.html *)
module CCCP : sig
  #include "messaging/cccp.mli"
end

#ifdef ENABLE_IRC
(* See: http://api.conreality.org/protocols/irc.html *)
module IRC : sig
  #include "messaging/irc.mli"
end
#endif

(* See: http://api.conreality.org/protocols/mqtt.html *)
module MQTT : sig
  #include "messaging/mqtt.mli"
end

(* See: http://api.conreality.org/protocols/ros.html *)
module ROS : sig
  #include "messaging/ros.mli"
end

(* See: http://api.conreality.org/protocols/stomp.html *)
(* See: https://stomp.github.io/stomp-specification-1.2.html *)
module STOMP : sig
  #include "messaging/stomp.mli"
end
