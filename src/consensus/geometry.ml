(* This is free and unencumbered software released into the public domain. *)

open Prelude

(* This is as good as we get with 32-bit floats (e.g. on ARMv6) *)
let eps = 1e-9

(* I read something about doing let f (float: x) (float:y) = *)
(* being more efficient, but it doesn't seem to work *)
let ( =. ) x y =
  let c = compare x y in
  if c = 0 then true else
  let ax = abs_float x in
  let ay = abs_float y in
  let amax = if ax > ay then ax else ay in
  let max = if 1. > amax then 1. else amax in
  if max = infinity then false else
  abs_float (x -. y) <= eps *. max

(* Vectors and points *)

module V2t = struct
  type t = { x: float; y: float }
  let i = [| (fun v -> v.x); (fun v -> v.y); |]
end

(* TODO: Make points and vectors separate modules *)
module P2t = V2t

module V2 = struct
  open V2t
  type t = V2t.t

  let create x y = { x = x; y = y }
  let x v = v.x
  let y v = v.y
  let el v n = i.(n) v

  let zero = create 0. 0.
  let unitx = create 1. 0.
  let unity = create 0. 1.
  let invert v = create (-. v.x) (-. v.y)
  let neg v = invert v
  let add a b = create (a.x +. b.x) (a.y +. b.y)
  let ( + ) a b = add a b
  let sub a b = create (a.x -. b.x) (a.y -. b.y)
  let ( - ) a b = sub a b
  let eq a b = a.x =. b.x && a.y =. b.y
  let ( = ) a b = eq a b
  let smul a f = create (a.x *. f) (a.y *. f)
  let ( * ) a f = smul a f
  let opposite a b = if a = invert b then true else false
  let dotproduct a b = a.x *. b.x +. a.y *. b.y
  let magnitude v = sqrt ((v.x *. v.x) +. (v.y *. v.y))
  let magnitude2 v = (v.x *. v.x) +. (v.y *. v.y)
  let normalize v =
    if v = zero then v else (* TODO: True? *)
    create (v.x /. magnitude v) (v.y /. magnitude v)
  let distance a b = sqrt ((a.x -. b.x) ** 2. +. (a.y -. b.y) ** 2.)
end

module P2 = V2

type v2 = V2.t
type p2 = V2.t

module V3t = struct
  type t = { x: float; y: float; z: float }
  let i = [| (fun v -> v.x); (fun v -> v.y); (fun v -> v.z); |]
end

module P3t = V3t

module V3 = struct
  open V3t
  type t = V3t.t

  let create x y z = { x; y; z }
  let x v = v.x
  let y v = v.y
  let z v = v.z
  let el v n = i.(n) v

  let zero = create 0. 0. 0.
  let unitx = create 1. 0. 0.
  let unity = create 0. 1. 0.
  let unitz = create 0. 0. 1.
  let invert v = create (-. v.x) (-. v.y) (-. v.z)
  let neg v = invert v
  let add a b = create (a.x +. b.x) (a.y +. b.y) (a.z +. b.z)
  let ( + ) a b = add a b
  let sub a b = create (a.x -. b.x) (a.y -. b.y) (a.z -. b.z)
  let ( - ) a b = sub a b
  let eq a b = a.x =. b.x && a.y =. b.y && a.z =. b.z
  let ( = ) a b = eq a b
  let smul a f = create (a.x *. f) (a.y *. f) (a.z *. f)
  let ( * ) a f = smul a f
  let opposite a b = a = invert b
  let dotproduct a b = a.x *. b.x +. a.y *. b.y +. a.z *. b.z

  let crossproduct a b =
    create (a.y *. b.z -. a.z *. b.y)
           (a.z *. b.x -. a.x *. b.z)
           (a.x *. b.y -. a.y *. b.x)

  let magnitude v = sqrt ((v.x *. v.x) +. (v.y *. v.y) +. (v.z *. v.z))
  let magnitude2 v = (v.x *. v.x) +. (v.y *. v.y) +. (v.z *. v.z)

  let normalize v =
    if v = zero then v else (* TODO: True? *)
    create (v.x /. magnitude v) (v.y /. magnitude v) (v.z /. magnitude v)

  let distance a b =
    sqrt ((a.x -. b.x) ** 2. +. (a.y -. b.y) ** 2. +. (a.z -. b.z) ** 2.)

  let print fmt v = Format.fprintf fmt "@[<1>(%g@ %g@ %g)@]" v.x v.y v.z
end

type v3 = V3.t
type v = V3.t
type p3 = V3.t
type p = V3.t

module P3 = V3
module P = V3
module V = V3

(* Matrices *)

module M2t = struct
  type t = { e00: float; e01: float;
             e10: float; e11: float }
  let i = [| (fun m -> m.e00); (fun m -> m.e01);
             (fun m -> m.e10); (fun m -> m.e11); |]
end

module M2 = struct
  open M2t
  type t = M2t.t

  (* V elements in row-major order: https://en.wikipedia.org/wiki/Row-major_order *)
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

  let add a b =
    create (a.e00 +. b.e00) (a.e01 +. b.e01)
           (a.e10 +. b.e10) (a.e11 +. b.e11)
  let ( + ) a b = add a b

  let sub a b =
    create (a.e00 -. b.e00) (a.e01 -. b.e01)
           (a.e10 -. b.e10) (a.e11 -. b.e11)
  let ( - ) a b = sub a b

  let eq a b =
    a.e00 =. b.e00 && a.e01 =. b.e01 &&
    a.e10 =. b.e10 && a.e11 =. b.e11
  let ( = ) a b = eq a b

  let smul m f =
    create (m.e00 *. f) (m.e01 *. f)
           (m.e10 *. f) (m.e11 *. f)

  let transpose m =
    create m.e00 m.e10
           m.e01 m.e11

  let mul a b =
    if a = id then b else
    if b = id then a else
    create (a.e00 *. b.e00 +. a.e01 *. b.e10) (a.e00 *. b.e01 +. a.e01 *. b.e11)
           (a.e10 *. b.e00 +. a.e11 *. b.e10) (a.e10 *. b.e01 +. a.e11 *. b.e11)
  let ( * ) a b = mul a b

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

type m2 = M2.t

