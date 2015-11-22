(* This is free and unencumbered software released into the public domain. *)
(* TODO: consensus_epsilon is probably too small to use here *)

open Prelude
open Prelude.Float

(* Points *)

module P2t = struct
  type t = { x: float; y: float }
  let i = [| (fun p -> p.x); (fun p -> p.y); |]
end

module P2 = struct
  open P2t
  type t = P2t.t
  let create x y = { x = x; y = y }
  let x p = p.x
  let y p = p.y
  let el p n = i.(n) p
  let zero = create 0. 0.
  let eq p q = (p.x =. q.x) && (p.y =. q.y)
  let ( = ) p q = eq p q
  let mid p q = create ((p.x +. q.x) *. 0.5) ((p.y +. q.y) *. 0.5)
  let distance p q = sqrt ((p.x -. q.x) ** 2. +. (p.y -. q.y) ** 2.)
  let to_string p = Format.sprintf "@[<1>(%g@ %g)@]" p.x p.y
end

type p2 = P2.t

module P3t = struct
  type t = { x: float; y: float; z: float }
  let i = [| (fun p -> p.x); (fun p -> p.y); (fun p -> p.z); |]
end

module P3 = struct
  open P3t
  type t = P3t.t
  let create x y z = { x = x; y = y; z = z }
  let x p = p.x
  let y p = p.y
  let z p = p.z
  let el p n = i.(n) p
  let zero = create 0. 0. 0.
  let eq p q = (p.x =. q.x) && (p.y =. q.y) && (p.z =. q.z)
  let ( = ) p q = eq p q
  let mid p q = create ((p.x +. q.x) *. 0.5) ((p.y +. q.y) *. 0.5) ((p.z +. q.z) *. 0.5)
  let distance a b =
    sqrt ((a.x -. b.x) ** 2. +. (a.y -. b.y) ** 2. +. (a.z -. b.z) ** 2.)
  let to_string p = Format.sprintf "@[<1>(%g@ %g@ %g)@]" p.x p.y p.z
end

type p3 = P3.t
type p = P3.t
module P = P3

(* Vectors *)

module V2t = struct
  type t = { x: float; y: float }
  let i = [| (fun v -> v.x); (fun v -> v.y); |]
end

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
  let to_string v = Format.sprintf "@[<1>(%g@ %g)@]" v.x v.y
end

type v2 = V2.t

module V3t = struct
  type t = { x: float; y: float; z: float }
  let i = [| (fun v -> v.x); (fun v -> v.y); (fun v -> v.z); |]
end

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

  let to_string v = Format.sprintf "@[<1>(%g@ %g@ %g)@]" v.x v.y v.z
end

type v3 = V3.t
type v = V3.t
module V = V3

module V4t = struct
  type t = { x: float; y: float; z: float; w: float }
  let i = [| (fun v -> v.x); (fun v -> v.y); (fun v -> v.z); (fun v -> v.w) |]
end

module V4 = struct
  open V4t
  type t = V4t.t

  let create x y z w = { x; y; z; w }
  let x v = v.x
  let y v = v.y
  let z v = v.z
  let w v = v.w
  let el v n = i.(n) v

  let zero = create 0. 0. 0. 0.
  let unitx = create 1. 0. 0. 0.
  let unity = create 0. 1. 0. 0.
  let unitz = create 0. 0. 1. 0.
  let unitw = create 0. 0. 0. 1.
  let invert v = create (-. v.x) (-. v.y) (-. v.z) (-. v.w)
  let neg v = invert v
  let add a b = create (a.x +. b.x) (a.y +. b.y) (a.z +. b.z) (a.w +. b.w)
  let ( + ) a b = add a b
  let sub a b = create (a.x -. b.x) (a.y -. b.y) (a.z -. b.z) (a.w -. b.w)
  let ( - ) a b = sub a b
  let eq a b = a.x =. b.x && a.y =. b.y && a.z =. b.z && a.w =. b.w
  let ( = ) a b = eq a b
  let smul a f = create (a.x *. f) (a.y *. f) (a.z *. f) (a.w *. f)
  let ( * ) a f = smul a f
  let opposite a b = a = invert b
  let dotproduct a b = a.x *. b.x +. a.y *. b.y +. a.z *. b.z +. a.w *. b.w
  let magnitude v = sqrt ((v.x *. v.x) +. (v.y *. v.y) +. (v.z *. v.z) +. (v.w *. v.w))
  let magnitude2 v = (v.x *. v.x) +. (v.y *. v.y) +. (v.z *. v.z) +. (v.w *. v.w)

  let normalize v =
    if v = zero then v else (* TODO: True? *)
      create (v.x /. magnitude v) (v.y /. magnitude v) (v.z /. magnitude v) (v.w /. magnitude v)

  let to_string v = Format.sprintf "@[<1>(%g@ %g@ %g@ %g)@]" v.x v.y v.z v.w
end

type v4 = V4.t

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

  (* Elements in row-major order: https://en.wikipedia.org/wiki/Row-major_order *)
  let create e00 e01 e10 e11 = { e00 = e00; e01 = e01;
                                 e10 = e10; e11 = e11 }

  let e00 m = m.e00
  let e01 m = m.e01
  let e10 m = m.e10
  let e11 m = m.e11
  let zero = create 0. 0. 0. 0.
  let id = create 1. 0. 0. 1.

  let el row col = i.(2 * row + col)

  let neg m = create
      (-. m.e00) (-. m.e01)
      (-. m.e10) (-. m.e11)

  let add a b = create
      (a.e00 +. b.e00) (a.e01 +. b.e01)
      (a.e10 +. b.e10) (a.e11 +. b.e11)
  let ( + ) a b = add a b

  let sub a b = create
      (a.e00 -. b.e00) (a.e01 -. b.e01)
      (a.e10 -. b.e10) (a.e11 -. b.e11)
  let ( - ) a b = sub a b

  let eq a b =
    a.e00 =. b.e00 && a.e01 =. b.e01 &&
    a.e10 =. b.e10 && a.e11 =. b.e11
  let ( = ) a b = eq a b

  let smul m f = create
      (m.e00 *. f) (m.e01 *. f)
      (m.e10 *. f) (m.e11 *. f)

  let transpose m = create
      m.e00 m.e10
      m.e01 m.e11

  let mul a b =
    if a = id then b else
    if b = id then a else
      create
        (a.e00 *. b.e00 +. a.e01 *. b.e10) (a.e00 *. b.e01 +. a.e01 *. b.e11)
        (a.e10 *. b.e00 +. a.e11 *. b.e10) (a.e10 *. b.e01 +. a.e11 *. b.e11)
  let ( * ) a b = mul a b

  let emul a b = create
      (a.e00 *. b.e00) (a.e01 *. b.e01)
      (a.e10 *. b.e10) (a.e11 *. b.e11)

  let ediv a b = create
      (a.e00 /. b.e00) (a.e01 /. b.e01)
      (a.e10 /. b.e10) (a.e11 /. b.e11)

  let det a = a.e00 *. a.e11 -. a.e01 *. a.e10

  let trace a = a.e00 +. a.e11

  let inverse a =
    (* TODO: "A matrix is invertible if and only if its determinant is nonzero." -- wiki
       Throw an exception? *)
    let d = det a in
    create
      (   a.e11 /. d) (-. a.e01 /. d)
      (-. a.e10 /. d) (   a.e00 /. d)

  let to_string m = Format.sprintf "@[<1>|%g@ %g@|\n|%g@ %g|@]" m.e00 m.e01 m.e10 m.e11
end

type m2 = M2.t

module M3t = struct
  type t = {
    e00: float; e01: float; e02: float;
    e10: float; e11: float; e12: float;
    e20: float; e21: float; e22: float
  }
  let i = [|
    (fun m -> m.e00); (fun m -> m.e01); (fun m -> m.e02);
    (fun m -> m.e10); (fun m -> m.e11); (fun m -> m.e12);
    (fun m -> m.e20); (fun m -> m.e21); (fun m -> m.e22);
  |]
end

module M3 = struct
  open M3t
  type t = M3t.t

  (* Elements in row-major order: https://en.wikipedia.org/wiki/Row-major_order *)
  let create e00 e01 e02 e10 e11 e12 e20 e21 e22 =
    {
      e00 = e00; e01 = e01; e02 = e02;
      e10 = e10; e11 = e11; e12 = e12;
      e20 = e20; e21 = e21; e22 = e22
    }

  let e00 m = m.e00
  let e01 m = m.e01
  let e02 m = m.e02
  let e10 m = m.e10
  let e11 m = m.e11
  let e12 m = m.e12
  let e20 m = m.e20
  let e21 m = m.e21
  let e22 m = m.e22
  let zero = create
      0. 0. 0.
      0. 0. 0.
      0. 0. 0.
  let id = create
      1. 0. 0.
      0. 1. 0.
      0. 0. 1.

  let el row col = i.(3 * row + col)

  let neg m = create
      (-. m.e00) (-. m.e01) (-. m.e02)
      (-. m.e10) (-. m.e11) (-. m.e12)
      (-. m.e20) (-. m.e21) (-. m.e22)

  let add a b = create
      (a.e00 +. b.e00) (a.e01 +. b.e01) (a.e02 +. b.e02)
      (a.e10 +. b.e10) (a.e11 +. b.e11) (a.e12 +. b.e12)
      (a.e20 +. b.e20) (a.e21 +. b.e21) (a.e22 +. b.e22)
  let ( + ) a b = add a b

  let sub a b = create
      (a.e00 -. b.e00) (a.e01 -. b.e01) (a.e02 -. b.e02)
      (a.e10 -. b.e10) (a.e11 -. b.e11) (a.e12 -. b.e12)
      (a.e20 -. b.e20) (a.e21 -. b.e21) (a.e22 -. b.e22)
  let ( - ) a b = sub a b

  let eq a b =
    a.e00 =. b.e00 && a.e01 =. b.e01 && a.e02 =. b.e02 &&
    a.e10 =. b.e10 && a.e11 =. b.e11 && a.e02 =. b.e02 &&
    a.e20 =. b.e20 && a.e21 =. b.e21 && a.e02 =. b.e02
  let ( = ) a b = eq a b

  let smul m f = create
      (m.e00 *. f) (m.e01 *. f) (m.e02 *. f)
      (m.e10 *. f) (m.e11 *. f) (m.e12 *. f)
      (m.e20 *. f) (m.e21 *. f) (m.e22 *. f)

  let transpose m = create
      m.e00 m.e10 m.e20
      m.e01 m.e11 m.e21
      m.e02 m.e12 m.e22

  let mul a b =
    if a = id then b else
    if b = id then a else
      create
        (a.e00 *. b.e00 +. a.e01 *. b.e10 +. a.e02 *. b.e20) (a.e00 *. b.e01 +. a.e01 *. b.e11 +. a.e02 *. b.e21) (a.e00 *. b.e02 +. a.e01 *. b.e12 +. a.e02 *. b.e22)
        (a.e10 *. b.e00 +. a.e11 *. b.e10 +. a.e12 *. b.e20) (a.e10 *. b.e01 +. a.e11 *. b.e11 +. a.e12 *. b.e21) (a.e10 *. b.e02 +. a.e11 *. b.e12 +. a.e12 *. b.e22)
        (a.e20 *. b.e00 +. a.e21 *. b.e10 +. a.e22 *. b.e20) (a.e20 *. b.e01 +. a.e21 *. b.e11 +. a.e22 *. b.e21) (a.e20 *. b.e02 +. a.e21 *. b.e12 +. a.e22 *. b.e22)
  let ( * ) a b = mul a b

  let emul a b = create
      (a.e00 *. b.e00) (a.e01 *. b.e01) (a.e02 *. b.e02)
      (a.e10 *. b.e10) (a.e11 *. b.e11) (a.e12 *. b.e12)
      (a.e20 *. b.e20) (a.e21 *. b.e21) (a.e22 *. b.e22)

  let ediv a b = create
      (a.e00 /. b.e00) (a.e01 /. b.e01) (a.e02 /. b.e02)
      (a.e10 /. b.e10) (a.e11 /. b.e11) (a.e12 /. b.e12)
      (a.e20 /. b.e20) (a.e21 /. b.e21) (a.e22 /. b.e22)

  let det a =
    a.e00 *. a.e11 *. a.e22 +.
    a.e01 *. a.e12 *. a.e20 +.
    a.e02 *. a.e10 *. a.e21 -.
    a.e02 *. a.e11 *. a.e20 -.
    a.e01 *. a.e10 *. a.e22 -.
    a.e00 *. a.e12 *. a.e21

  let trace a = a.e00 +. a.e11 +. a.e22

  let inverse a =
    (* TODO: "A matrix is invertible if and only if its determinant is nonzero." -- wiki
       Throw an exception? *)
    let d = det a in
    let i00 = (a.e11 *. a.e22) -. (a.e21 *. a.e12) in
    let i10 = (a.e01 *. a.e22) -. (a.e21 *. a.e02) in
    let i20 = (a.e01 *. a.e12) -. (a.e11 *. a.e02) in
    let i01 = (a.e10 *. a.e22) -. (a.e20 *. a.e12) in
    let i11 = (a.e00 *. a.e22) -. (a.e20 *. a.e02) in
    let i21 = (a.e00 *. a.e12) -. (a.e10 *. a.e02) in
    let i02 = (a.e10 *. a.e21) -. (a.e20 *. a.e11) in
    let i12 = (a.e00 *. a.e21) -. (a.e20 *. a.e01) in
    let i22 = (a.e00 *. a.e11) -. (a.e10 *. a.e01) in
    create
      (   i00 /. d) (-. i10 /. d) (   i20 /. d)
      (-. i01 /. d) (   i11 /. d) (-. i21 /. d)
      (   i02 /. d) (-. i12 /. d) (   i22 /. d)

  let to_string m = Format.sprintf "@[<1>|%g@ %g@ %g@|\n|%g@ %g@ %g|\n|%g@ %g@ %g|@]" m.e00 m.e01 m.e02 m.e10 m.e11 m.e12 m.e20 m.e21 m.e22
end

type m3 = M3.t

module M4t = struct
  type t = {
    e00: float; e01: float; e02: float; e03: float;
    e10: float; e11: float; e12: float; e13: float;
    e20: float; e21: float; e22: float; e23: float;
    e30: float; e31: float; e32: float; e33: float
  }
  let i = [|
    (fun m -> m.e00); (fun m -> m.e01); (fun m -> m.e02); (fun m -> m.e03);
    (fun m -> m.e10); (fun m -> m.e11); (fun m -> m.e12); (fun m -> m.e13);
    (fun m -> m.e20); (fun m -> m.e21); (fun m -> m.e22); (fun m -> m.e23);
    (fun m -> m.e30); (fun m -> m.e31); (fun m -> m.e32); (fun m -> m.e33);
  |]
end

module M4 = struct
  open M4t
  type t = M4t.t

  (* Elements in row-major order: https://en.wikipedia.org/wiki/Row-major_order *)
  let create
      e00 e01 e02 e03
      e10 e11 e12 e13
      e20 e21 e22 e23
      e30 e31 e32 e33 =
    {
      e00 = e00; e01 = e01; e02 = e02; e03 = e03;
      e10 = e10; e11 = e11; e12 = e12; e13 = e13;
      e20 = e20; e21 = e21; e22 = e22; e23 = e23;
      e30 = e30; e31 = e31; e32 = e32; e33 = e33;
    }

  let e00 m = m.e00
  let e01 m = m.e01
  let e02 m = m.e02
  let e03 m = m.e03
  let e10 m = m.e10
  let e11 m = m.e11
  let e12 m = m.e12
  let e13 m = m.e13
  let e20 m = m.e20
  let e21 m = m.e21
  let e22 m = m.e22
  let e23 m = m.e23
  let e30 m = m.e30
  let e31 m = m.e31
  let e32 m = m.e32
  let e33 m = m.e33
  let zero = create
      0. 0. 0. 0.
      0. 0. 0. 0.
      0. 0. 0. 0.
      0. 0. 0. 0.
  let id = create
      1. 0. 0. 0.
      0. 1. 0. 0.
      0. 0. 1. 0.
      0. 0. 0. 1.

  let el row col = i.(4 * row + col)

  let neg m = create
      (-. m.e00) (-. m.e01) (-. m.e02) (-. m.e03)
      (-. m.e10) (-. m.e11) (-. m.e12) (-. m.e13)
      (-. m.e20) (-. m.e21) (-. m.e22) (-. m.e23)
      (-. m.e30) (-. m.e31) (-. m.e32) (-. m.e33)

  let add a b = create
      (a.e00 +. b.e00) (a.e01 +. b.e01) (a.e02 +. b.e02) (a.e03 +. b.e03)
      (a.e10 +. b.e10) (a.e11 +. b.e11) (a.e12 +. b.e12) (a.e13 +. b.e13)
      (a.e20 +. b.e20) (a.e21 +. b.e21) (a.e22 +. b.e22) (a.e23 +. b.e23)
      (a.e30 +. b.e30) (a.e31 +. b.e31) (a.e32 +. b.e32) (a.e33 +. b.e33)
  let ( + ) a b = add a b

  let sub a b = create
      (a.e00 -. b.e00) (a.e01 -. b.e01) (a.e02 -. b.e02) (a.e03 -. b.e03)
      (a.e10 -. b.e10) (a.e11 -. b.e11) (a.e12 -. b.e12) (a.e13 -. b.e13)
      (a.e20 -. b.e20) (a.e21 -. b.e21) (a.e22 -. b.e22) (a.e23 -. b.e23)
      (a.e30 -. b.e30) (a.e31 -. b.e31) (a.e32 -. b.e32) (a.e33 -. b.e33)
  let ( - ) a b = sub a b

  let eq a b =
    a.e00 =. b.e00 && a.e01 =. b.e01 && a.e02 =. b.e02 && a.e03 =. b.e03 &&
    a.e10 =. b.e10 && a.e11 =. b.e11 && a.e02 =. b.e02 && a.e13 =. b.e13 &&
    a.e20 =. b.e20 && a.e21 =. b.e21 && a.e02 =. b.e02 && a.e23 =. b.e23 &&
    a.e30 =. b.e30 && a.e31 =. b.e31 && a.e02 =. b.e02 && a.e33 =. b.e33
  let ( = ) a b = eq a b

  let smul m f = create
      (m.e00 *. f) (m.e01 *. f) (m.e02 *. f) (m.e03 *. f)
      (m.e10 *. f) (m.e11 *. f) (m.e12 *. f) (m.e13 *. f)
      (m.e20 *. f) (m.e21 *. f) (m.e22 *. f) (m.e23 *. f)
      (m.e30 *. f) (m.e31 *. f) (m.e32 *. f) (m.e33 *. f)

  let transpose m = create
      m.e00 m.e10 m.e20 m.e30
      m.e01 m.e11 m.e21 m.e31
      m.e02 m.e12 m.e22 m.e32
      m.e03 m.e13 m.e23 m.e33

  let mul a b =
    if a = id then b else
    if b = id then a else
      create
        (a.e00 *. b.e00 +. a.e01 *. b.e10 +. a.e02 *. b.e20 +. a.e03 *. b.e30)
        (a.e00 *. b.e01 +. a.e01 *. b.e11 +. a.e02 *. b.e21 +. a.e03 *. b.e31)
        (a.e00 *. b.e02 +. a.e01 *. b.e12 +. a.e02 *. b.e22 +. a.e03 *. b.e32)
        (a.e00 *. b.e03 +. a.e01 *. b.e13 +. a.e02 *. b.e23 +. a.e03 *. b.e33)
        (a.e10 *. b.e00 +. a.e11 *. b.e10 +. a.e12 *. b.e20 +. a.e13 *. b.e30)
        (a.e10 *. b.e01 +. a.e11 *. b.e11 +. a.e12 *. b.e21 +. a.e13 *. b.e31)
        (a.e10 *. b.e02 +. a.e11 *. b.e12 +. a.e12 *. b.e22 +. a.e13 *. b.e32)
        (a.e10 *. b.e03 +. a.e11 *. b.e13 +. a.e12 *. b.e23 +. a.e13 *. b.e33)
        (a.e20 *. b.e00 +. a.e21 *. b.e10 +. a.e22 *. b.e20 +. a.e23 *. b.e30)
        (a.e20 *. b.e01 +. a.e21 *. b.e11 +. a.e22 *. b.e21 +. a.e23 *. b.e31)
        (a.e20 *. b.e02 +. a.e21 *. b.e12 +. a.e22 *. b.e22 +. a.e23 *. b.e32)
        (a.e20 *. b.e03 +. a.e21 *. b.e13 +. a.e22 *. b.e23 +. a.e23 *. b.e33)
        (a.e30 *. b.e00 +. a.e31 *. b.e10 +. a.e32 *. b.e20 +. a.e33 *. b.e30)
        (a.e30 *. b.e01 +. a.e31 *. b.e11 +. a.e32 *. b.e21 +. a.e33 *. b.e31)
        (a.e30 *. b.e02 +. a.e31 *. b.e12 +. a.e32 *. b.e22 +. a.e33 *. b.e32)
        (a.e30 *. b.e03 +. a.e31 *. b.e13 +. a.e32 *. b.e23 +. a.e33 *. b.e33)
  let ( * ) a b = mul a b

  let emul a b = create
      (a.e00 *. b.e00) (a.e01 *. b.e01) (a.e02 *. b.e02) (a.e03 *. b.e03)
      (a.e10 *. b.e10) (a.e11 *. b.e11) (a.e12 *. b.e12) (a.e13 *. b.e13)
      (a.e20 *. b.e20) (a.e21 *. b.e21) (a.e22 *. b.e22) (a.e23 *. b.e23)
      (a.e30 *. b.e30) (a.e31 *. b.e31) (a.e32 *. b.e32) (a.e33 *. b.e33)

  let ediv a b = create
      (a.e00 /. b.e00) (a.e01 /. b.e01) (a.e02 /. b.e02) (a.e03 /. b.e03)
      (a.e10 /. b.e10) (a.e11 /. b.e11) (a.e12 /. b.e12) (a.e13 /. b.e13)
      (a.e20 /. b.e20) (a.e21 /. b.e21) (a.e22 /. b.e22) (a.e23 /. b.e23)
      (a.e30 /. b.e30) (a.e31 /. b.e31) (a.e32 /. b.e32) (a.e33 /. b.e33)

  let det a =
    (* 16 * 6 - 1 ops = 95 ops. It may be more efficient to use
     * http://www.geometrictools.com/Documentation/LaplaceExpansionTheorem.pdf *)
    a.e00 *. a.e11 *. a.e22 *. a.e33 -. a.e00 *. a.e11 *. a.e23 *. a.e32 -. a.e00 *. a.e12 *. a.e21 *. a.e33 +. a.e00 *. a.e12 *. a.e23 *. a.e31 +.
    a.e00 *. a.e13 *. a.e21 *. a.e32 -. a.e00 *. a.e13 *. a.e22 *. a.e31 -. a.e01 *. a.e10 *. a.e22 *. a.e33 +. a.e01 *. a.e10 *. a.e23 *. a.e32 +.
    a.e01 *. a.e12 *. a.e20 *. a.e33 -. a.e01 *. a.e12 *. a.e23 *. a.e30 -. a.e01 *. a.e13 *. a.e20 *. a.e32 +. a.e01 *. a.e13 *. a.e22 *. a.e30 +.
    a.e02 *. a.e10 *. a.e21 *. a.e33 -. a.e02 *. a.e10 *. a.e23 *. a.e31 -. a.e02 *. a.e11 *. a.e20 *. a.e33 +. a.e02 *. a.e11 *. a.e23 *. a.e30 +.
    a.e02 *. a.e13 *. a.e20 *. a.e31 -. a.e02 *. a.e13 *. a.e21 *. a.e30 -. a.e03 *. a.e10 *. a.e21 *. a.e32 +. a.e03 *. a.e10 *. a.e22 *. a.e31 +.
    a.e03 *. a.e11 *. a.e20 *. a.e32 -. a.e03 *. a.e11 *. a.e22 *. a.e30 -. a.e03 *. a.e12 *. a.e20 *. a.e31 +. a.e03 *. a.e12 *. a.e21 *. a.e30

  let trace a = a.e00 +. a.e11 +. a.e22 +. a.e33

  let inverse a = a
  (* TODO let inverse a = TODO *)
    (* TODO: "A matrix is invertible if and only if its determinant is nonzero." -- wiki
     * Throw an exception? *)
(*
    let d = det a in
    let i00 = (a.e11 *. a.e22) -. (a.e21 *. a.e12) in
    let i10 = (a.e01 *. a.e22) -. (a.e21 *. a.e02) in
    let i20 = (a.e01 *. a.e12) -. (a.e11 *. a.e02) in
    let i01 = (a.e10 *. a.e22) -. (a.e20 *. a.e12) in
    let i11 = (a.e00 *. a.e22) -. (a.e20 *. a.e02) in
    let i21 = (a.e00 *. a.e12) -. (a.e10 *. a.e02) in
    let i02 = (a.e10 *. a.e21) -. (a.e20 *. a.e11) in
    let i12 = (a.e00 *. a.e21) -. (a.e20 *. a.e01) in
    let i22 = (a.e00 *. a.e11) -. (a.e10 *. a.e01) in
    create
      (   i00 /. d) (-. i10 /. d) (   i20 /. d)
      (-. i01 /. d) (   i11 /. d) (-. i21 /. d)
      (   i02 /. d) (-. i12 /. d) (   i22 /. d)
*)

  let to_string m = Format.sprintf "@[<1>|%g@ %g@ %g@ %g@|\n|%g@ %g@ %g@ %g@|\n|%g@ %g@ %g@ %g@|\n|%g@ %g@ %g@ %g|@]"
      m.e00 m.e01 m.e02 m.e03
      m.e10 m.e11 m.e12 m.e13
      m.e20 m.e21 m.e22 m.e23
      m.e30 m.e31 m.e32 m.e33
end

type m4 = M4.t

(* Quaternions *)

module Qt = struct
  type t = { r: float; a: float; b: float; c: float; }
end

module Q = struct
  open Qt
  type t = Qt.t
  let create r a b c = { r = r; a = a; b = b; c = c }
  let r q = q.r
  let a q = q.a
  let b q = q.b
  let c q = q.c
  let zero = create 0. 0. 0. 0.
  let real q = q.r
  let imag q = ( q.a, q.b, q.c )
  let of_scalar s = create s 0. 0. 0.
  let to_list q = [q.r; q.a; q.b; q.c]

  let of_list = function
    | [r; a; b; c] -> (create r a b c)
    | _ -> invalid_arg "Q.of_list"

  let conj q = create q.r (-. q.a) (-. q.b) (-. q.c)
  let smul q r = create (q.r *. r) (q.a *. r) (q.b *. r) (q.c *. r)
  let sdiv q r = create (q.r /. r) (q.a /. r) (q.b /. r) (q.c /. r)
  let norm2 q = q.r *. q.r +. q.a *. q.a +. q.b *. q.b +. q.c *. q.c
  let norm q = sqrt (norm2 q)
  let magnitude q = norm2 q
  let length q = norm2 q
  let inv q = sdiv (conj q) (norm2 q)
  let add p q = create (p.r +. q.r) (p.a +. q.a) (p.b +. q.b) (p.c +. q.c)
  let sub p q = create (p.r -. q.r) (p.a -. q.a) (p.b -. q.b) (p.c -. q.c)

  let mul p q = create
      (p.r *. q.r -. p.a *. q.a -. p.b *. q.b -. p.c *. q.c)
      (p.r *. q.a +. q.r *. p.a +. q.c *. p.b -. q.b *. p.c)
      (p.r *. q.b +. q.r *. p.b +. p.c *. q.a -. q.c *. p.a)
      (p.r *. q.c +. q.r *. p.c +. p.a *. q.b -. q.a *. p.b)

  let div p q = mul p (inv q)
  let ( + ) p q = add p q
  let ( - ) p q = sub p q
  let ( * ) p q = mul p q
  let ( / ) p q = div p q
  let eq p q = p.r =. q.r && p.a =. q.a && p.b =. q.b && p.c =. q.c
  let ( = ) p q = eq p q
  let addr q r = create (q.r +. r) q.a q.b q.c
  let subr q r = create (q.r -. r) q.a q.b q.c
  let mulr q r = create (q.r *. r) q.a q.b q.c
  let divr q r = create (q.r /. r) q.a q.b q.c
  let neg q = create (-. q.r) (-. q.a) (-. q.b) (-. q.c)
  let unit q = sdiv q (norm q)
  let dot p q = p.r *. q.r +. p.a *. q.a +. p.b *. q.b +. p.c *. q.c
(*
  let cos_alpha p q = (dot p q) /. ((norm p) *. (norm q))
  let alpha p q = acos (cos_alpha p q)
*)
  (* http://www.cc.gatech.edu/~ndantam3/note/dantam-quaternion.pdf *)
  let alpha p q = 2. *. (atan2 (norm (p - q)) (norm (p + q)))
  let cos_alpha p q = cos (alpha p q)
  let distance p q = norm (p - q)

  let slerp p q t =
    (* http://web.mit.edu/2.998/www/QuaternionReport1.pdf *)
    if p = q then p else
      let th = abs_float (alpha p q) in
      (* TODO: consensus_epsilon is probably too small to use here *)
      let sin_th =
        if th <=. consensus_epsilon
        then th
        else (sin th) in
      sdiv (add (smul p ((sin (1.0 -. t)) *. th)) (smul q (sin (t *. th)))) sin_th

  let squad p q cp cq t =
    (* http://web.mit.edu/2.998/www/QuaternionReport1.pdf *)
    (* http://www.3dgep.com/understanding-quaternions/#SQUAD *)
    let a = slerp p cp t in
    let b = slerp q cq t in
    slerp a b (2.0 *. t *. (1.0 -. t))

  let nlerp p q t =
    (* Lerp(q0; q1; h) = q0(1 h) + q1h *)
    (* http://web.mit.edu/2.998/www/QuaternionReport1.pdf *)
    (smul q t) + (smul p (1.0 -. t))

  let exp q =
    (* https://en.wikipedia.org/wiki/Quaternion#Exponential.2C_logarithm.2C_and_power *)
    let v = V3.create q.a q.b q.c in
    let n = V3.magnitude v in
    let exp_r = exp q.r in
    let u = V3.smul v ((sin n) /. n) in
    create (exp_r *. cos n) (exp_r *. V3.x u) (exp_r *. V3.y u) (exp_r *. V3.z u)

  let log q =
    (* https://en.wikipedia.org/wiki/Quaternion#Exponential.2C_logarithm.2C_and_power *)
    let qn = norm q in
    let v = V3.create q.a q.b q.c in
    let vn = V3.magnitude v in
    let u = V3.smul v (q.r /. vn /. qn) in
    create (log qn) (V3.x u) (V3.y u) (V3.z u)

  let pow q a =
    (* http://www.cc.gatech.edu/~ndantam3/note/dantam-quaternion.pdf *)
    (* probably very expensive *)
    exp (smul (log q) a)
  let ( ** ) q a = pow q a

  let to_string q = Format.sprintf "@[<1>[%g@, (%g@ %g@ %g)@]]" q.r q.a q.b q.c
end

type q = Q.t
