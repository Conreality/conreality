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
  let print fmt p = Format.fprintf fmt "@[<1>(%g@ %g)@]" p.x p.y (*BISECT-IGNORE*)
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
  let print fmt p = Format.fprintf fmt "@[<1>(%g@ %g@ %g)@]" p.x p.y p.z (*BISECT-IGNORE*)
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
  let print fmt v = Format.fprintf fmt "@[<1>(%g@ %g)@]" v.x v.y (*BISECT-IGNORE*)
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

  let print fmt v = Format.fprintf fmt "@[<1>(%g@ %g@ %g)@]" v.x v.y v.z (*BISECT-IGNORE*)
end

type v3 = V3.t
type v = V3.t
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

  let print fmt m = Format.fprintf fmt "@[<1>(%g@ %g@\n%g@ %g)@]" m.e00 m.e01 m.e10 m.e11 (*BISECT-IGNORE*)
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

  let print fmt m = Format.fprintf fmt "@[<1>(%g@ %g@ %g@\n%g@ %g@ %g\n%g@ %g@ %g)@]" m.e00 m.e01 m.e02 m.e10 m.e11 m.e12 m.e20 m.e21 m.e22 (*BISECT-IGNORE*)
end

type m3 = M3.t

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
  let add p q = create (p.r +. q.r) (p.a +. q.a) (p.b +. q.b) (p.c +. q.c)
  let sub p q = create (p.r -. q.r) (p.a -. q.a) (p.b -. q.b) (p.c -. q.c)
  let mul p q = create
      (p.r *. q.r -. p.a *. q.a -. p.b *. q.b -. p.c *. q.c)
      (p.r *. q.a +. q.r *. p.a +. p.a *. p.b -. q.b *. p.c)
      (p.r *. q.b +. q.r *. p.b +. p.c *. q.a -. q.c *. p.a)
      (p.r *. q.c +. q.r *. p.c +. p.a *. q.b -. q.a *. p.b)
  let ( + ) p q = add p q
  let ( - ) p q = sub p q
  let ( * ) p q = mul p q
  let eq p q = p.r =. q.r && p.a =. q.a && p.b =. q.b && p.c =. q.c
  let ( = ) p q = eq p q
  let addr q r = create (q.r +. r) q.a q.b q.c
  let subr q r = create (q.r -. r) q.a q.b q.c
  let mulr q r = create (q.r *. r) q.a q.b q.c
  let divr q r = create (q.r /. r) q.a q.b q.c
  let smul q r = create (q.r *. r) (q.a *. r) (q.b *. r) (q.c *. r)
  let sdiv q r = create (q.r /. r) (q.a /. r) (q.b /. r) (q.c /. r)
  let norm2 q = q.r *. q.r +. q.a *. q.a +. q.b *. q.b +. q.c *. q.c
  let norm q = sqrt (norm2 q)
  let conj q = create q.r (-. q.a) (-. q.b) (-. q.c)
  let neg q = create (-. q.r) (-. q.a) (-. q.b) (-. q.c)
  let inv q = sdiv (conj q) (norm2 q)
  let unit q = sdiv q (norm q)
  let dot p q = p.r *. q.r +. p.a *. q.a +. p.b *. q.b +. p.c *. q.c
  let cos_theta p q = (dot p q) /. ((norm p) *. (norm q))
  let theta p q = acos (cos_theta p q)
  let slerp p q t =
    if p = q then p else
      let th = abs_float (theta p q) in
      (* TODO: consensus_epsilon is probably too small to use here *)
      let sin_th = if th <=. consensus_epsilon then th else (sin th) in
      sdiv (add (smul p ((sin (1.0 -. t)) *. th)) (smul q (sin (t *. th)))) sin_th
  let distance p q = norm (p - q)
    (*
  let nlerp = t -> t
  let squad = t -> t
  let of_euler = M3.t -> t
  let to_euler q =
  let cross = t -> t -> t
       *)
end

type q = Q.t
