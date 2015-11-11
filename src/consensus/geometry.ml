(* This is free and unencumbered software released into the public domain. *)

(* Vectors and points *)

module V2t = struct
  type t = { x: float; y: float }
  let i = [| (fun v -> v.x); (fun v -> v.y); |]
end

module P2t = V2t

module Vector2 = struct
  open V2t
  type t = V2t.t

  let create x y = { x = x; y = y }
  let x v = v.x
  let y v = v.y
  let el n = V2t.i.(n)

  let zero = create 0. 0.
  let unitx = create 1. 0.
  let unity = create 0. 1.
  let invert v = create (-. v.x) (-. v.y)
  let neg v = invert v
  let ( + ) a b = create (a.x +. b.x) (a.y +. b.y)
  let ( - ) a b = create (a.x -. b.x) (a.y -. b.y)
  let ( = ) a b = a.x = b.x && a.y = b.y
  let smul a f = create (a.x *. f) (a.y *. f)
  let ( * ) a f = smul a f
  let opposite a b = if a = invert b then true else false
  let dotproduct a b = a.x *. b.x +. a.y *. b.y
  let magnitude v = sqrt ((v.x *. v.x) +. (v.y *. v.y))
  let magnitude2 v = (v.x *. v.x) +. (v.y *. v.y)
  let normalize v =
    if v = zero then v else
    create (v.x /. magnitude v) (v.y /. magnitude v)
  let distance a b = sqrt ((a.x -. b.x) ** 2. +. (a.y -. b.y) ** 2.)
end

module Point2 = Vector2

type vector2 = Vector2.t
type point2 = Vector2.t

module V3t = struct
  type t = { x: float; y: float; z: float }
  let i = [| (fun v -> v.x); (fun v -> v.y); (fun v -> v.z); |]
end

module P3t = V3t

module Vector3 = struct
  open V3t
  type t = V3t.t

  let create x y z = { x; y; z }
  let x v = v.x
  let y v = v.y
  let z v = v.z
  let el n = i.(n)

  let zero = create 0. 0. 0.
  let unitx = create 1. 0. 0.
  let unity = create 0. 1. 0.
  let unitz = create 0. 0. 1.
  let invert v = create (-. v.x) (-. v.y) (-. v.z)
  let neg v = invert v
  let ( + ) a b = create (a.x +. b.x) (a.y +. b.y) (a.z +. b.z)
  let ( - ) a b = create (a.x -. b.x) (a.y -. b.y) (a.z -. b.z)
  let ( = ) a b = a.x = b.x && a.y = b.y && a.z = b.z
  let smul a f = create (a.x *. f) (a.y *. f) (a.z *. f)
  let ( * ) a f = smul a f
  let opposite a b = a = invert b
  let dotproduct a b = a.x *. b.x +. a.y *. b.y +. a.z *. b.z

  let crossproduct a b =
    create (a.y *. b.z -. a.z *. b.y) (a.z *. b.x -. a.x *. b.z) (a.x *. b.y -. a.y *. b.x)

  let magnitude v = sqrt ((v.x *. v.x) +. (v.y *. v.y) +. (v.z *. v.z))
  let magnitude2 v = (v.x *. v.x) +. (v.y *. v.y) +. (v.z *. v.z)

  let normalize v =
    if v = zero then v else
    create (v.x /. magnitude v) (v.y /. magnitude v) (v.z /. magnitude v)

  let distance a b =
    sqrt ((a.x -. b.x) ** 2. +. (a.y -. b.y) ** 2. +. (a.z -. b.z) ** 2.)
end

module Point3 = Vector3
module Vector = Vector3
module Point = Vector3

type vector3 = Vector3.t
type point3 = Vector3.t

(* Matrices *)

module M2t = struct
  type t = { e00: float; e01: float;
             e10: float; e11: float }
  let i = [| (fun m -> m.e00); (fun m -> m.e01);
             (fun m -> m.e10); (fun m -> m.e11); |]
end

module Matrix2 = struct
  open M2t
  type t = M2t.t

  (* Vector elements in row-major order: https://en.wikipedia.org/wiki/Row-major_order *)
  let create e00 e01 e10 e11 = { e00 = e00; e01 = e01;
                                 e10 = e10; e11 = e11 }

  let e00 m = m.e00
  let e01 m = m.e01
  let e10 m = m.e10
  let e11 m = m.e11
  let zero = create 0. 0. 0. 0.
  let id = create 1. 0. 0. 1.

  let el row col = i.(2 * row + col)

  let neg m =
    create (-. m.e00) (-. m.e01)
           (-. m.e10) (-. m.e11)

  let ( + ) a b =
    create (a.e00 +. b.e00) (a.e01 +. b.e01)
           (a.e10 +. b.e10) (a.e11 +. b.e11)

  let ( - ) a b =
    create (a.e00 -. b.e00) (a.e01 -. b.e01)
           (a.e10 -. b.e10) (a.e11 -. b.e11)

  let ( = ) a b =
    a.e00 = b.e00 && a.e01 = b.e01 &&
    a.e10 = b.e10 && a.e11 = b.e11

  let smul m f =
    create (m.e00 *. f) (m.e01 *. f)
           (m.e10 *. f) (m.e11 *. f)

  let transpose m =
    create m.e00 m.e10
           m.e01 m.e11

  let ( * ) a b =
    if a = id then b else
    if b = id then a else
    create (a.e00 *. b.e00 +. a.e01 *. b.e10) (a.e00 *. b.e01 +. a.e01 *. b.e11)
           (a.e10 *. b.e00 +. a.e11 *. b.e10) (a.e10 *. b.e01 +. a.e11 *. b.e11)

  let emul a b =
    create (a.e00 *. b.e00) (a.e01 *. b.e01)
           (a.e10 *. b.e10) (a.e11 *. b.e11)

  let ediv a b =
    create (a.e00 /. b.e00) (a.e01 /. b.e01)
           (a.e10 /. b.e10) (a.e11 /. b.e11)

  let det a = a.e00 *. a.e11 -. a.e01 *. a.e10

  let trace a = a.e00 +. a.e11

  let inverse a =
    let d = det a in
    create (   a.e11 /. d) (-. a.e01 /. d)
           (-. a.e10 /. d) (   a.e00 /. d)

end

type matrix2 = Matrix2.t
type m2 = Matrix2.t

module M2 = Matrix2
