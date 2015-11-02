(* This is free and unencumbered software released into the public domain. *)

module Vector = struct
  type t = { x: float; y: float; z: float }

  let create x y z = { x; y; z }

  let invert self = create (-. self.x) (-. self.y) (-. self.z)
end

module Point = Vector

type point = Point.t

type vector = Vector.t
