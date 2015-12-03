(* This is free and unencumbered software released into the public domain. *)

(** World model. *)

module Object_color : sig
  #include "model/object_color.mli"
end

module Object_shape : sig
  #include "model/object_shape.mli"
end

module Intent_designation : sig
  #include "model/intent_designation.mli"
end

module Threat_level : sig
  #include "model/threat_level.mli"
end

module Object : sig
  #include "model/object.mli"
end

module Network : sig
  #include "model/network.mli"
end

module Swarm : sig
  #include "model/swarm.mli"
end

module Asset : sig
  #include "model/asset.mli"
end

module Target : sig
  #include "model/target.mli"
end

module Theater : sig
  #include "model/theater.mli"
end
