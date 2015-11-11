(* This is free and unencumbered software released into the public domain. *)

type vector3 = { x: float; y: float; z: float }
type point3 = vector3

module Vector3 = struct
  type t = vector3

  let create x y z = { x; y; z }

  let x v = v.x
  let y v = v.y
  let z v = v.z

  let zero = create 0. 0. 0.

  let invert v =
    create (-. v.x) (-. v.y) (-. v.z)

  let ( + ) a b =
    create (a.x +. b.x) (a.y +. b.y) (a.z +. b.z)

  let ( - ) a b =
    create (a.x -. b.x) (a.y -. b.y) (a.z -. b.z)

  let ( = ) a b =
    a.x = b.x && a.y = b.y && a.z = b.z

  let ( * ) a f =
    create (a.x *. f) (a.y *. f) (a.z *. f)

  let opposite a b =
    a = invert b

  let dotproduct a b =
    a.x *. b.x +. a.y *. b.y +. a.z *. b.z

  let crossproduct a b =
    create (a.y *. b.z -. a.z *. b.y) (a.z *. b.x -. a.x *. b.z) (a.x *. b.y -. a.y *. b.x)

  let magnitude v =
    sqrt ((v.x *. v.x) +. (v.y *. v.y) +. (v.z *. v.z))

  let normalize v =
    create (v.x /. magnitude v) (v.y /. magnitude v) (v.z /. magnitude v)
end

module Point3 = Vector3
module Vector = Vector3
module Point = Vector3

type matrix2 = { e00: float; e01: float;
                 e10: float; e11: float }
type m2 = matrix2

module Matrix2 = struct
  type t = matrix2

  (* Vector elements in row-major order: https://en.wikipedia.org/wiki/Row-major_order *)
  let create e00 e01 e10 e11 = { e00; e01;
                                 e10; e11 }

  let e00 m = m.e00
  let e01 m = m.e01
  let e10 m = m.e10
  let e11 m = m.e11
  let zero = create 0. 0. 0. 0.
  let id = create 1. 0. 0. 1.
  let invert m =
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

module M2 = Matrix2
