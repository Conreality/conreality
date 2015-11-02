(* This is free and unencumbered software released into the public domain. *)

module Point = struct
  type t = { x: float; y: float; z: float }
end

type point = Point.t
