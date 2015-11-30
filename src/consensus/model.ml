(* This is free and unencumbered software released into the public domain. *)

open Prelude

module Shape = struct
  [%%include "model/shape.ml"]
end

module Object = struct
  [%%include "model/object.ml"]
end

module Theater = struct
  [%%include "model/theater.ml"]
end
