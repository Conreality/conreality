(* This is free and unencumbered software released into the public domain. *)

type vector = { x: float; y: float; z: float }
type point  = vector

module Vector = struct
  type t = vector

  let create x y z = { x; y; z }

  let x v = v.x
  let y v = v.y
  let z v = v.z

  let zero () =
    create 0. 0. 0.

  let ( + ) a b =
    create (a.x +. b.x) (a.y +. b.y) (a.z +. b.z)

  let ( - ) a b =
    create (a.x -. b.x) (a.y -. b.y) (a.z -. b.z)

  let ( = ) a b =
    if a.x = b.x && a.y = b.y && a.z = b.z then true else false

  let ( * ) a f =
    create (a.x *. f) (a.y *. f) (a.z *. f)

  let opposite a b =
    if a.x = -.b.x && a.y = -.b.y && a.z = -.b.z the true else false

  let dotproduct a b =
    a.x *. b.x + a.y *. b.y + a.z * b.z

  let crossproduct a b =
    create (a.y *. b.z - a.z *. b.y) (a.z *. b.x - a.x *. b.z) (a.x *. b.y - a.y *. b.x)

  let invert v =
    create (-. v.x) (-. v.y) (-. v.z)

  let magnitude v =
    sqrt ((v.x *. v.x) +. (v.y *. v.y) +. (v.z *. v.z))

  let normalize v =
    create (v.x /. magnitude v) (v.y /. magnitude v) (v.z /. magnitude v)
end

module Point = Vector
