(* This is free and unencumbered software released into the public domain. *)

open Prelude

module Object_color = struct
  [%%include "model/object_color.ml"]
end

module Object_shape = struct
  [%%include "model/object_shape.ml"]
end

module Intent_designation = struct
  [%%include "model/intent_designation.ml"]
end

module Threat_level = struct
  [%%include "model/threat_level.ml"]
end

module Object = struct
  [%%include "model/object.ml"]
end

module Network = struct
  [%%include "model/network.ml"]
end

module Swarm = struct
  [%%include "model/swarm.ml"]
end

module Asset = struct
  [%%include "model/asset.ml"]
end

module Target = struct
  [%%include "model/target.ml"]
end

module Theater = struct
  [%%include "model/theater.ml"]
end
