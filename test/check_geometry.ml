(* This is free and unencumbered software released into the public domain. *)

open Check_common
open Consensus.Geometry

let e = 2.71828
let pi = 3.14159
let phi = 1.61803

module V2_test = struct
  (* 2D Vectors *)

  let tvec2_1 = V2.create (3.) (1.)
  let tvec2_1opposite = V2.create (-3.) (-1.)
  let tvec2_2 = V2.create e pi
  let tvec2_0 = V2.zero

  let v2_to_list v = [(V2.x v); (V2.y v)]
  (* Keep this one operating on floats to avoid depending on V2.eq *)
  let create () = same_float_list [e; pi] (v2_to_list tvec2_2)
  let x () = same_float 3. (V2.x tvec2_1)
  let y () = same_float pi (V2.y tvec2_2)
  let el () = same_float 3. (V2.el tvec2_1 0)
  (* Keep this one operating on floats to avoid depending on V2.eq *)
  let zero () = same_float_list [0.; 0.] (v2_to_list tvec2_0)
  let unitx () = same_bool true (V2.eq V2.unitx (V2.create 1. 0.))
  let unity () = same_bool true (V2.eq V2.unity (V2.create 0. 1.))
  let invert () = same_bool true (V2.eq tvec2_1opposite (V2.invert tvec2_1))
  let neg () = same_bool true (V2.eq tvec2_1opposite (V2.neg tvec2_1))

  let add_expected = V2.create (5.71828) (4.14159)
  let add () =
    let v = V2.add tvec2_1 tvec2_2 in
    same_bool true (V2.eq v add_expected)
  let op_add () =
    let v = V2.( + ) tvec2_1 tvec2_2 in
    same_bool true (V2.eq v add_expected)

  let sub_expected = V2.create (0.28172) (-2.14159)
  let sub () =
    let v = V2.sub tvec2_1 tvec2_2 in
    same_bool true (V2.eq v sub_expected)
  let op_sub () =
    let v = V2.( - ) tvec2_1 tvec2_2 in
    same_bool true (V2.eq v sub_expected)

  let eq () = same_bool true (V2.eq V2.zero V2.zero)
  let op_eq () = same_bool true (V2.eq V2.zero V2.zero)

  let smul_expected = V2.create (6.) (2.)
  let smul () =
    let v = V2.smul tvec2_1 2. in
    same_bool true (V2.eq v smul_expected)
  let op_smul () =
    let v = V2.( * ) tvec2_1 2. in
    same_bool true (V2.eq v smul_expected)

  let opposite () = same_bool true (V2.opposite tvec2_1 tvec2_1opposite)
  let opposite_failure () = same_bool false (V2.opposite tvec2_1 tvec2_2)
  let dotproduct () = same_float 11.29643 (V2.dotproduct tvec2_1 tvec2_2)
  let magnitude () = same_float 3.16227766 (V2.magnitude tvec2_1)
  let magnitude2 () = same_float 10. (V2.magnitude2 tvec2_1)
  let magnitude2_2 () = same_float 17.258633887 (V2.magnitude2 tvec2_2)
  let magnitude3 () = same_float 4.154351199 (V2.magnitude tvec2_2)
  let magnitude2_0 () = same_float 0. (V2.magnitude2 tvec2_0)
  let magnitude0 () = same_float 0. (V2.magnitude tvec2_0)

  let normalize () =
    (* normalize v = v.x / magnitude v, v.y / magnitude v *)
    (* magnitude 3 1 = 3.16227766 *)
    (* normalize 3 1 = 0.948683298 0.316227766 *)
    let v = V2.normalize tvec2_1 in
    let vn = V2.create (0.948683298) (0.316227766) in
    same_bool true (V2.eq v vn)

  let normalize2 () =
    (* magnitude 2.71828 3.14159 = 4.154351199 *)
    (* normalize 2.71828 3.14159 = 0.654321185 0.704657139 *)
    let v = V2.normalize tvec2_2 in
    let vn = V2.create (0.654321185) (0.756216759) in
    same_bool true (V2.eq v vn)

  let normalize0 () =
    same_bool true (V2.eq tvec2_0 (V2.normalize tvec2_0))

  let to_string () =
    same_string "(2.71828 3.14159)" (V2.to_string tvec2_2)
end

module V3_test = struct
  (* 3D Vectors *)

  let tvec3_1 = V3.create (3.) (1.) (2.)
  let tvec3_1opposite = V3.create (-3.) (-1.) (-2.)
  let tvec3_2 = V3.create e pi phi
  let tvec3_0 = V3.zero

  let v3_to_list v = [(V3.x v); (V3.y v); (V3.z v)]
  (* Keep this one operating on floats to avoid depending on V3.eq *)
  let create () = same_float_list [e; pi; phi] (v3_to_list tvec3_2)
  let x () = same_float 3. (V3.x tvec3_1)
  let y () = same_float pi (V3.y tvec3_2)
  let z () = same_float 2. (V3.z tvec3_1)
  let el () = same_float 3. (V3.el tvec3_1 0)
  (* Keep this one operating on floats to avoid depending on V3.eq *)
  let zero () = same_float_list [0.; 0.; 0.] (v3_to_list tvec3_0)
  let unitx () = same_bool true (V3.eq V3.unitx (V3.create 1. 0. 0.))
  let unity () = same_bool true (V3.eq V3.unity (V3.create 0. 1. 0.))
  let unitz () = same_bool true (V3.eq V3.unitz (V3.create 0. 0. 1.))
  let invert () = same_bool true (V3.eq tvec3_1opposite (V3.invert tvec3_1))
  let neg () = same_bool true (V3.eq tvec3_1opposite (V3.neg tvec3_1))

  let add_expected = V3.create (5.71828) (4.14159) (3.61803)
  let add () =
    let v = V3.add tvec3_1 tvec3_2 in
    same_bool true (V3.eq v add_expected)
  let op_add () =
    let v = V3.( + ) tvec3_1 tvec3_2 in
    same_bool true (V3.eq v add_expected)

  let sub_expected = V3.create (0.28172) (-2.14159) (0.38197)
  let sub () =
    let v = V3.sub tvec3_1 tvec3_2 in
    same_bool true (V3.eq v sub_expected)
  let op_sub () =
    let v = V3.( - ) tvec3_1 tvec3_2 in
    same_bool true (V3.eq v sub_expected)

  let eq () = same_bool true (V3.eq V3.zero V3.zero)
  let op_eq () = same_bool true (V3.zero = V3.zero)

  let smul_expected = V3.create (6.) (2.) (4.)
  let smul () =
    let v = V3.smul tvec3_1 2. in
    same_bool true (V3.eq v smul_expected)
  let op_smul () =
    let v = V3.( * ) tvec3_1 2. in
    same_bool true (V3.eq v smul_expected)

  let opposite () = same_bool true (V3.opposite tvec3_1 tvec3_1opposite)
  let opposite_failure () = same_bool false (V3.opposite tvec3_1 tvec3_2)

  let dotproduct () = same_float 14.53249 (V3.dotproduct tvec3_1 tvec3_2)

  let crossproduct () =
    let v = V3.crossproduct tvec3_1 tvec3_1 in
    let w = V3.create (0.) (0.) (0.) in
    same_bool true (V3.eq v w)

  (* a = 2.71828, 3.14159, 1.61803 *)
  (* b = 3, 1, 2 *)
  (* cross product = < a2b3 - a3b2, a3b1 - a1b3, a1b2 - a2b1 > *)
  let a1 = 2.71828 let a2 = 3.14159 let a3 = 1.61803
  let b1 = 3.      let b2 = 1.      let b3 = 2.
  let wx = (V3.create (a2 *. b3 -. a3 *. b2)
              (a3 *. b1 -. a1 *. b3)
              (a1 *. b2 -. a2 *. b1))
  let vx = (V3.crossproduct tvec3_2 tvec3_1)
  let crossproduct2 () =
    same_bool true (V3.eq vx wx)

  let magnitude () = same_float 3.741657387 (V3.magnitude tvec3_1)
  let magnitude2 () = same_float 14. (V3.magnitude2 tvec3_1)
  let magnitude2_2 () = same_float 19.876654967 (V3.magnitude2 tvec3_2)
  let magnitude3 () = same_float 4.458324233 (V3.magnitude tvec3_2)
  let magnitude2_0 () = same_float 0. (V3.magnitude2 tvec3_0)
  let magnitude0 () = same_float 0. (V3.magnitude tvec3_0)

  let normalize () =
    (* normalize v = v.x / magnitude v, v.y / magnitude v, v.z / magnitude z  *)
    (* magnitude 3 1 2 = 3.741657387 *)
    (* normalize 3 1 2 = 0.801783726 0.267261242 0.534522484 *)
    let v = V3.normalize tvec3_1 in
    let vn = V3.create (0.801783726) (0.267261242) (0.534522484) in
    same_bool true (V3.eq v vn)

  let normalize2 () =
    (* magnitude 2.71828 3.14159 1.61803 = 4.458324233 *)
    (* normalize 2.71828 3.14159 1.61803 = 0.609708908 0.704657139 0.362923358 *)
    let v = V3.normalize tvec3_2 in
    let vn = V3.create (0.609708908) (0.704657139) (0.362923358) in
    same_bool true (V3.eq v vn)

  let normalize0 () =
    same_bool true (V3.eq tvec3_0 (V3.normalize tvec3_0))

  let to_string () =
    same_string "(2.71828 3.14159 1.61803)" (V3.to_string tvec3_2)
end

module V4_test = struct
  (* 3D Vectors *)

  let tvec4_1 = V4.create (3.) (1.) (2.) (4.)
  let tvec4_1opposite = V4.create (-3.) (-1.) (-2.) (-4.)
  let tvec4_2 = V4.create e pi phi 0.
  let tvec4_0 = V4.zero

  let v4_to_list v = [(V4.x v); (V4.y v); (V4.z v); (V4.w v)]
  (* Keep this one operating on floats to avoid depending on V4.eq *)
  let create () = same_float_list [e; pi; phi; 0.] (v4_to_list tvec4_2)
  let x () = same_float 3. (V4.x tvec4_1)
  let y () = same_float pi (V4.y tvec4_2)
  let z () = same_float 2. (V4.z tvec4_1)
  let w () = same_float 4. (V4.w tvec4_1)
  let el () = same_float 3. (V4.el tvec4_1 0)
  (* Keep this one operating on floats to avoid depending on V4.eq *)
  let zero () = same_float_list [0.; 0.; 0.; 0.] (v4_to_list tvec4_0)
  let unitx () = same_bool true (V4.eq V4.unitx (V4.create 1. 0. 0. 0.))
  let unity () = same_bool true (V4.eq V4.unity (V4.create 0. 1. 0. 0.))
  let unitz () = same_bool true (V4.eq V4.unitz (V4.create 0. 0. 1. 0.))
  let unitw () = same_bool true (V4.eq V4.unitw (V4.create 0. 0. 0. 1.))
  let invert () = same_bool true (V4.eq tvec4_1opposite (V4.invert tvec4_1))
  let neg () = same_bool true (V4.eq tvec4_1opposite (V4.neg tvec4_1))

  let add_expected = V4.create (5.71828) (4.14159) (3.61803) (4.)
  let add () =
    let v = V4.add tvec4_1 tvec4_2 in
    same_bool true (V4.eq v add_expected)
  let op_add () =
    let v = V4.( + ) tvec4_1 tvec4_2 in
    same_bool true (V4.eq v add_expected)

  let sub_expected = V4.create (0.28172) (-2.14159) (0.38197) (4.)
  let sub () =
    let v = V4.sub tvec4_1 tvec4_2 in
    same_bool true (V4.eq v sub_expected)
  let op_sub () =
    let v = V4.( - ) tvec4_1 tvec4_2 in
    same_bool true (V4.eq v sub_expected)

  let eq () = same_bool true (V4.eq V4.zero V4.zero)
  let op_eq () = same_bool true (V4.zero = V4.zero)

  let smul_expected = V4.create (6.) (2.) (4.) (8.)
  let smul () =
    let v = V4.smul tvec4_1 2. in
    same_bool true (V4.eq v smul_expected)
  let op_smul () =
    let v = V4.( * ) tvec4_1 2. in
    same_bool true (V4.eq v smul_expected)

  let opposite () = same_bool true (V4.opposite tvec4_1 tvec4_1opposite)
  let opposite_failure () = same_bool false (V4.opposite tvec4_1 tvec4_2)

  let dotproduct () = same_float 14.53249 (V4.dotproduct tvec4_1 tvec4_2)

  let magnitude () = same_float 5.477225575 (V4.magnitude tvec4_1)
  let magnitude2 () = same_float 30. (V4.magnitude2 tvec4_1)
  let magnitude2_2 () = same_float 19.876654967 (V4.magnitude2 tvec4_2)
  let magnitude3 () = same_float 4.458324233 (V4.magnitude tvec4_2)
  let magnitude2_0 () = same_float 0. (V4.magnitude2 tvec4_0)
  let magnitude0 () = same_float 0. (V4.magnitude tvec4_0)

  let normalize () =
    let v = V4.normalize tvec4_1 in
    let sqrt30 = sqrt 30. in
    let vn = V4.create (sqrt30 /. 10.) (sqrt30 /. 30.) (sqrt30 /. 15.) (2. *. sqrt30 /. 15.) in
    same_bool true (V4.eq v vn)

  let normalize2 () =
    let v = V4.normalize tvec4_2 in
    let vn = V4.create (0.609708908) (0.704657139) (0.362923358) (0.) in
    same_bool true (V4.eq v vn)

  let normalize0 () =
    same_bool true (V4.eq tvec4_0 (V4.normalize tvec4_0))

  let to_string () =
    same_string "(2.71828 3.14159 1.61803 0)" (V4.to_string tvec4_2)
end

module P2_test = struct
  (* 2D Points *)

  let tp2_1 = P2.create (3.) (1.)
  let tp2_2 = P2.create (e) (pi)
  let tp2_zero = P2.zero

  let p2_to_list p = [ (P2.x p); (P2.y p); ]
  (* Keep this one operating on floats to avoid depending on P2.eq *)
  let create () = same_float_list [e; pi] (p2_to_list tp2_2)
  let x () = same_float 3. (P2.x tp2_1)
  let y () = same_float pi (P2.y tp2_2)
  let el () = same_float 3. (P2.el tp2_1 0)
  (* Keep this one operating on floats to avoid depending on P2.eq *)
  let zero () = same_float_list [0.; 0.] (p2_to_list tp2_zero)
  let eq () = same_bool true (P2.eq P2.zero P2.zero)
  let op_eq () = same_bool true (P2.( = ) P2.zero P2.zero)
  let mid () = same_bool true (P2.eq (P2.mid tp2_1 tp2_zero) (P2.create (1.5) (0.5)))
  let distance () = same_float 3.16227766 (P2.distance tp2_1 tp2_zero)
  let to_string () = same_string "(2.71828 3.14159)" (P2.to_string tp2_2)
end

module P3_test = struct
  (* 3D Points *)

  let tp3_1 = P3.create (3.) (1.) (2.)
  let tp3_2 = P3.create (e) (pi) (phi)
  let tp3_zero = P3.zero

  let p3_to_list p = [ (P3.x p); (P3.y p); (P3.z p) ]
  (* Keep this one operating on floats to avoid depending on P3.eq *)
  let create () = same_float_list [e; pi; phi] (p3_to_list tp3_2)
  let x () = same_float 3. (P3.x tp3_1)
  let y () = same_float pi (P3.y tp3_2)
  let z () = same_float 2. (P3.z tp3_1)
  let el () = same_float 3. (P3.el tp3_1 0)
  (* Keep this one operating on floats to avoid depending on P3.eq *)
  let zero () = same_float_list [0.; 0.; 0.] (p3_to_list tp3_zero)
  let eq () = same_bool true (P3.eq P3.zero P3.zero)
  let op_eq () = same_bool true (P3.( = )P3.zero P3.zero)
  let mid () = same_bool true ((P3.mid tp3_1 tp3_zero) = (P3.create (1.5) (0.5) (1.0)))
  let distance () = same_float 3.741657387 (P3.distance tp3_1 tp3_zero)
  let to_string () = same_string "(2.71828 3.14159 1.61803)" (P3.to_string tp3_2)
end

module M2_test = struct
  (* 2x2 Matrices *)

  let tm2_1 = M2.create
      (3.) (1.)
      (2.) (7.)
  let tm2_2 = M2.create
      (e) (pi)
      (phi) (0.)
  let tm2_3 = M2.create
      (6.) (2.)
      (4.) (14.)
  let tm2_zero = M2.zero

  let m2_to_list m = [ (M2.e00 m); (M2.e01 m); (M2.e10 m); (M2.e11 m) ]
  (* Keep this one operating on floats to avoid depending on P3.eq *)
  let create () = same_float_list [e; pi; phi; 0.] (m2_to_list tm2_2)
  let e00 () = same_float e (M2.e00 tm2_2)
  let e01 () = same_float pi (M2.e01 tm2_2)
  let e10 () = same_float phi (M2.e10 tm2_2)
  let e11 () = same_float 0. (M2.e11 tm2_2)
  (* Keep this one operating on floats to avoid depending on P3.eq *)
  let zero () = same_float_list [0.; 0.; 0.; 0.] (m2_to_list tm2_zero)
  let id () = same_float_list [1.; 0.; 0.; 1.] (m2_to_list M2.id)
  let el () = same_float 3.14159 (M2.el 0 1 tm2_2)
  let neg () = same_bool true (M2.eq (M2.neg tm2_1) (M2.create (-3.) (-1.) (-2.) (-7.)))
  let add () = same_bool true (M2.eq (M2.create (6.) (2.) (4.) (14.)) (M2.add tm2_1 tm2_1))
  let op_add () = same_bool true (M2.eq (M2.create (6.) (2.) (4.) (14.)) (M2.(+) tm2_1 tm2_1))
  let sub () = same_bool true (M2.eq (M2.sub tm2_1 tm2_1) tm2_zero)
  let op_sub () = same_bool true (M2.eq (M2.( - ) tm2_1 tm2_1) tm2_zero)
  let eq () = same_bool true (M2.eq M2.zero M2.zero)
  let op_eq () = same_bool true (M2.( = ) M2.zero M2.zero)
  let smul () = same_bool true (M2.eq (M2.smul tm2_1 (2.)) tm2_3)

  let transpose () =
    let expected = M2.create
        (3.) (2.)
        (1.) (7.) in
    same_bool true (M2.eq (M2.transpose tm2_1) expected)

  (*let m2print m = M2.print Format.std_formatter m*)

  let expected_mul = M2.create
      (9.77287) (9.42477)
      (16.76277) (6.28318)

  let mul () =
    same_bool true (M2.eq (M2.mul tm2_1 M2.id) tm2_1);
    same_bool true (M2.eq (M2.mul M2.id tm2_1) tm2_1);
    same_bool true (M2.eq (M2.mul tm2_1 tm2_2) expected_mul)

  let op_mul () =
    same_bool true (M2.eq (M2.( * ) tm2_1 M2.id) tm2_1);
    same_bool true (M2.eq (M2.( * ) M2.id tm2_1) tm2_1);
    same_bool true (M2.eq (M2.( * ) tm2_1 tm2_2) expected_mul)

  let emul () =
    let expected = M2.create
        (8.15484) (3.14159)
        (3.23606) (0.) in
    same_bool true (M2.eq (M2.emul tm2_1 tm2_2) expected)

  let ediv () =
    let expected = M2.create
        (1.103639065879894687) (3.183101550488765530e-01)
        (1.236071024641075766) (infinity) in
    same_bool true (M2.eq (M2.ediv tm2_1 tm2_2) expected)

  let det () =
    same_float (19.) (M2.det tm2_1);
    same_float (-5.0831868677) (M2.det tm2_2)

  let trace () =
    same_float (10.) (M2.trace tm2_1);
    same_float (2.71828) (M2.trace tm2_2)

  let inverse () =
    let expected_1 = M2.create
        (3.684210526315789269e-01) (-5.263157894736842507e-02)
        (-1.052631578947368501e-01) (1.578947368421052821e-01) in
    let expected_2 = M2.create
        (1.110223024625156540e-16) (6.180355123205377721e-01)
        (3.183101550488764975e-01) (-5.347590145215230795e-01) in
    same_bool true (M2.eq (M2.inverse tm2_1) expected_1);
    same_bool true (M2.eq (M2.inverse tm2_2) expected_2)
  let to_string () = todo ()
end

module M3_test = struct
  (* 3x3 Matrices *)

  let tm3_1 = M3.create
      (3.) (1.) (4.)
      (2.) (7.) (5.)
      (6.) (-1.) (8.)
  let tm3_2 = M3.create
      (e) (pi) (1.)
      (phi) (0.) (2.)
      (3.) (4.) (-1.)
  let tm3_3 = M3.create
      (6.) (2.) (8.)
      (4.) (14.) (10.)
      (12.) (-2.) (16.)
  let tm3_zero = M3.zero

  let m3_to_list m = [
    (M3.e00 m); (M3.e01 m); M3.e02 m;
    (M3.e10 m); (M3.e11 m); M3.e12 m;
    (M3.e20 m); (M3.e21 m); M3.e22 m;
  ]

  (* Keep this one operating on floats to avoid depending on P3.eq *)
  let create () = same_float_list [e; pi; (1.); phi; (0.); (2.); (3.); (4.); (-1.);] (m3_to_list tm3_2)
  let e00 () = same_float e (M3.e00 tm3_2)
  let e01 () = same_float pi (M3.e01 tm3_2)
  let e02 () = same_float 1. (M3.e02 tm3_2)
  let e10 () = same_float phi (M3.e10 tm3_2)
  let e11 () = same_float 0. (M3.e11 tm3_2)
  let e12 () = same_float 2. (M3.e12 tm3_2)
  let e20 () = same_float 3. (M3.e20 tm3_2)
  let e21 () = same_float 4. (M3.e21 tm3_2)
  let e22 () = same_float (-1.) (M3.e22 tm3_2)
  (* Keep this one operating on floats to avoid depending on P3.eq *)
  let zero () = same_float_list [0.; 0.; 0.; 0.; 0.; 0.; 0.; 0.; 0.] (m3_to_list tm3_zero)
  let id () = same_float_list [1.; 0.; 0.; 0.; 1.; 0.; 0.; 0.; 1.;] (m3_to_list M3.id)
  let el () = same_float 4. (M3.el 2 1 tm3_2)
  let neg () = same_bool true (M3.eq (M3.neg tm3_1) (M3.create (-3.) (-1.) (-4.) (-2.) (-7.) (-5.) (-6.) (1.) (-8.)))
  let add () = same_bool true (M3.eq ((M3.add tm3_1 tm3_1)) tm3_3)
  let op_add () = same_bool true (M3.eq ((M3.(+) tm3_1 tm3_1)) tm3_3)
  let sub () = same_bool true (M3.eq (M3.sub tm3_1 tm3_1) tm3_zero)
  let op_sub () = same_bool true (M3.eq (M3.( - ) tm3_1 tm3_1) tm3_zero)
  let eq () = same_bool true (M3.eq M3.zero M3.zero)
  let op_eq () = same_bool true (M3.( = ) M3.zero M3.zero)
  let smul () = same_bool true (M3.eq (M3.smul tm3_1 (2.)) tm3_3)

  let transpose () =
    let expected = M3.create
        (3.) (2.) (6.)
        (1.) (7.) (-1.)
        (4.) (5.) (8.) in
    same_bool true (M3.eq (M3.transpose tm3_1) expected)

  (*let m3print m = M3.print Format.std_formatter m*)

  let expected_mul = M3.create
      (2.177287000000000106e+01) (2.542476999999999876e+01) (1.000000000000000000e+00)
      (3.176276999999999973e+01) (2.628318000000000154e+01) (1.100000000000000000e+01)
      (3.869164999999999566e+01) (5.084953999999999752e+01) (-4.000000000000000000e+00)

  let mul () =
    same_bool true (M3.eq (M3.mul tm3_1 M3.id) tm3_1);
    same_bool true (M3.eq (M3.mul M3.id tm3_1) tm3_1);
    same_bool true (M3.eq (M3.mul tm3_1 tm3_2) expected_mul)

  let op_mul () =
    same_bool true (M3.eq (M3.( * ) tm3_1 M3.id) tm3_1);
    same_bool true (M3.eq (M3.( * ) M3.id tm3_1) tm3_1);
    same_bool true (M3.eq (M3.( * ) tm3_1 tm3_2) expected_mul)

  let emul () =
    let expected = M3.create
        (8.154840000000000089e+00) (3.141589999999999883e+00) (4.000000000000000000e+00)
        (3.236060000000000159e+00) (0.000000000000000000e+00) (1.000000000000000000e+01)
        (1.800000000000000000e+01) (-4.000000000000000000e+00) (-8.000000000000000000e+00) in
    same_bool true (M3.eq (M3.emul tm3_1 tm3_2) expected)

  let ediv () =
    let expected = M3.create
        (1.103639065879894687e+00) (3.183101550488765530e-01) (4.000000000000000000e+00)
        (1.236071024641075766e+00) (infinity) (2.500000000000000000e+00)
        (2.000000000000000000e+00) (-2.500000000000000000e-01) (-8.000000000000000000e+00) in
    same_bool true (M3.eq (M3.ediv tm3_1 tm3_2) expected)

  let det () =
    same_float (21.) (M3.det tm3_1);
    same_float (8.6586068677) (M3.det tm3_2)

  let trace () =
    same_float (18.) (M3.trace tm3_1);
    same_float (1.71828) (M3.trace tm3_2)

  let inverse () =
    let expected_1 = M3.create
        (2.904761904761903324e+00) (-5.714285714285712858e-01) (-1.095238095238094456e+00)
        (6.666666666666665186e-01) (2.775557561562891351e-17) (-3.333333333333332593e-01)
        (-2.095238095238094456e+00) (4.285714285714284921e-01) (9.047619047619044341e-01) in
    let expected_2 = M3.create
        (-9.239361622760742243e-01) (8.247966571436486927e-01) (7.256571520112230500e-01)
        (8.798216752880003710e-01) (-6.604157097525038544e-01) (-4.410097442170073379e-01)
        (7.474782143237783671e-01) (-1.672728675790690622e-01) (-5.870675208343596463e-01) in
    same_bool true (M3.eq (M3.inverse tm3_1) expected_1);
    same_bool true (M3.eq (M3.inverse tm3_2) expected_2)
  let to_string () = todo ()
end

module Q_test = struct
  (* Quaternions *)
  let tq1 = Q.create (3.) (-1.) (4.) (1.)
  let tq2 = Q.create e pi phi 0.
  let tqz = Q.create 0. 0. 0. 0.

  let q_to_list q = [Q.r q; Q.a q; Q.b q; Q.c q]

  (* Keep this one operating on floats to avoid depending on Q.eq *)
  let create () = same_float_list [e; pi; phi; 0.] (q_to_list (Q.create e pi phi 0.))
  let r () = same_float e (Q.r tq2)
  let a () = same_float (-1.) (Q.a tq1)
  let b () = same_float phi (Q.b tq2)
  let c () = same_float (1.) (Q.c tq1)
  (* Keep this one operating on floats to avoid depending on Q.eq *)
  let zero () = same_float_list [0.; 0.; 0.; 0.] (q_to_list Q.zero)
  let real () = same_float e (Q.real tq2)
  let imag () = todo () (* TODO: needs to use a tuple or V3 *)
  let of_scalar () = same_bool true (Q.eq (Q.of_scalar 3.) (Q.create 3. 0. 0. 0.))
  let to_list () = same_float_list [e; pi; phi; 0.] (Q.to_list tq2)
  let of_list () = same_bool true (Q.eq tq2 (Q.of_list [e; pi; phi; 0.]))
  let conj () =
    same_bool true (Q.eq (Q.conj tq1) (Q.create (3.) (1.) (-4.) (-1.)));
    same_bool true (Q.eq (Q.conj tq2) (Q.create (e) (-. pi) (-. phi) (0.)))
  let smul () = same_bool true (Q.eq (Q.smul tq1 2.) (Q.create (6.) (-2.) (8.) (2.)))
  let sdiv () = same_bool true (Q.eq (Q.sdiv tq1 2.) (Q.create (1.5) (-0.5) (2.) (0.5)))
  let norm2 () =
    same_float 27. (Q.norm2 tq1);
    same_float 19.8766549674 (Q.norm2 tq2);
    same_float 0. (Q.norm2 tqz)
  let norm () =
    same_float 5.19615242270663 (Q.norm tq1);
    same_float 4.45832423309476 (Q.norm tq2);
    same_float 0. (Q.magnitude tqz)
  let magnitude () = norm ()
  let length () = norm ()
  let inv () =
    let etq1 = Q.create 0.111111111111111 0.0370370370370370 (-0.148148148148148) (-0.0370370370370370) in
    let etq2 = Q.create 0.136757417405408 (-0.158054260395050) (-0.0814035360906428) 0. in
    same_bool true (Q.eq (Q.inv tq1) etq1);
    same_bool true (Q.eq (Q.inv tq2) etq2)
  let add () =
    let ex = Q.create 5.71828 2.14159 5.61803 1. in
    same_bool true (Q.eq ex (Q.add tq1 tq2))
  let sub () =
    let ex = Q.create 0.28172 (-4.14159) 2.38197 1. in
    same_bool true (Q.eq ex (Q.sub tq1 tq2))
  let mul () =
    let ex1 = Q.create 4.82431 5.08846 18.8688 (-11.46611) in
    let ex2 = Q.create 4.82431 8.32452 12.58562 16.90267 in
    same_bool true (Q.eq ex1 (Q.mul tq1 tq2));
    same_bool true (Q.eq ex2 (Q.mul tq2 tq1))
  let div () =
    let ex1 = Q.create 0.577832136183746 (-0.529516662499915) 0.144764800954654 0.850377995076250 in
    let ex2 = Q.create 0.425384074074074 0.389815555555556 (-0.106571851851852) (-0.626024814814815) in
    same_bool true (Q.eq ex1 (Q.div tq1 tq2));
    same_bool true (Q.eq ex2 (Q.div tq2 tq1))
  let op_add () =
    let ex = Q.create 5.71828 2.14159 5.61803 1. in
    same_bool true (Q.eq ex (Q.( + ) tq1 tq2))
  let op_sub () =
    let ex = Q.create 0.28172 (-4.14159) 2.38197 1. in
    same_bool true (Q.eq ex (Q.( - ) tq1 tq2))
  let op_mul () =
    let ex1 = Q.create 4.82431 5.08846 18.8688 (-11.46611) in
    let ex2 = Q.create 4.82431 8.32452 12.58562 16.90267 in
    same_bool true (Q.eq ex1 (Q.( * ) tq1 tq2));
    same_bool true (Q.eq ex2 (Q.( * ) tq2 tq1))
  let op_div () =
    let ex1 = Q.create 0.577832136183746 (-0.529516662499915) 0.144764800954654 0.850377995076250 in
    let ex2 = Q.create 0.425384074074074 0.389815555555556 (-0.106571851851852) (-0.626024814814815) in
    same_bool true (Q.eq ex1 (Q.( / ) tq1 tq2));
    same_bool true (Q.eq ex2 (Q.( / ) tq2 tq1))
  let eq () = same_bool true (Q.eq tq1 tq1)
  let op_eq () = same_bool true (Q.( = ) tq1 tq1)
  let addr () = same_bool true (Q.eq (Q.addr tq1 1.) (Q.create (4.) (-1.) (4.) (1.)))
  let subr () = same_bool true (Q.eq (Q.subr tq1 1.) (Q.create (2.) (-1.) (4.) (1.)))
  let mulr () = same_bool true (Q.eq (Q.mulr tq1 2.) (Q.create (6.) (-1.) (4.) (1.)))
  let divr () = same_bool true (Q.eq (Q.divr tq1 2.) (Q.create (1.5) (-1.) (4.) (1.)))
  let neg () = same_bool true (Q.eq (Q.neg tq1) (Q.create (-3.) (1.) (-4.) (-1.)))
  (*let tq1 = Q.create (3.) (-1.) (4.) (1.)*)
  (*let tq2 = Q.create e pi phi 0.*)
  let unit () =
    let ex1 = Q.create 0.577350269189626 (-0.192450089729875) 0.769800358919501 0.192450089729875 in
    let ex2 = Q.create 0.609708908073986 0.704657139263120 0.362923357612517 0. in
    same_bool true (Q.eq ex1 (Q.unit tq1));
    same_bool true (Q.eq ex2 (Q.unit tq2))
  let dot () =
    same_float 11.48537 (Q.dot tq1 tq2);
    same_float 11.48537 (Q.dot tq2 tq1)
(*
  let cos_alpha () = same_float (-0.490025152519411) (Q.cos_alpha tq1 tq2)
  let alpha () = same_float 2.082914933779878 (Q.alpha tq1 tq2)
*)
  let cos_alpha () = todo ()
  let alpha () = todo ()
  let distance () =
    let ex = 4.88936754267871 in
    same_float ex (Q.distance tq1 tq2);
    same_float ex (Q.distance tq2 tq1)
(*
  let slerp () =
    let ex1 = Q.create 4.68762 0.316352 5.31884 1.14194 in
    let ex2 = Q.create 4.49669 3.12332 3.70445 0.46419 in
    same_bool true (Q.eq ex1 (Q.slerp tq1 tq2 0.2));
    same_bool true (Q.eq ex2 (Q.slerp tq2 tq1 0.2))
*)
  let slerp () = todo ()
  let squad () = todo ()
  let nlerp () = todo ()
  let exp () = todo ()
  let log () = todo ()
(*
  let log () =
    let ex1 = Q.create 1.647918433002165 0.225170286285347 (-0.900681145141387) (-0.225170286285347) in
    let ex2 = Q.create 1.494772962936871 0.813541778114865 0.419002798978605 0. in
    Printf.eprintf "expect: %s\n" (Q.to_string ex1); flush_all ();
    Printf.eprintf "result: %s\n" (Q.to_string (Q.log tq1)); flush_all ();
    same_bool true (Q.eq ex1 (Q.log tq1));
    Printf.eprintf "expect: %s\n" (Q.to_string ex2); flush_all ();
    Printf.eprintf "result: %s\n" (Q.to_string (Q.log tq2)); flush_all ();
    same_bool true (Q.eq ex2 (Q.log tq2))
*)
  let pow () = todo ()
  let op_exp () = todo ()
  let to_string () = todo ()
end

let () =
  Alcotest.run "Consensus.Geometry test suite" [
    "Vector2", [
      (* 2D Vectors *)
      "V2.create",               `Quick, V2_test.create;
      "V2.x",                    `Quick, V2_test.x;
      "V2.y",                    `Quick, V2_test.y;
      "V2.element",              `Quick, V2_test.el;
      "V2.zero",                 `Quick, V2_test.zero;
      "V2.unitx",                `Quick, V2_test.unitx;
      "V2.unity",                `Quick, V2_test.unity;
      "V2.invert",               `Quick, V2_test.invert;
      "V2.neg",                  `Quick, V2_test.neg;
      "V2.add",                  `Quick, V2_test.add;
      "V2.op_add",               `Quick, V2_test.op_add;
      "V2.sub",                  `Quick, V2_test.sub;
      "V2.op_sub",               `Quick, V2_test.op_sub;
      "V2.eq",                   `Quick, V2_test.eq;
      "V2.op_eq",                `Quick, V2_test.op_eq;
      "V2.smul",                 `Quick, V2_test.smul;
      "V2.op_smul",              `Quick, V2_test.op_smul;
      "V2.opposite",             `Quick, V2_test.opposite;
      "V2.opposite failure",     `Quick, V2_test.opposite_failure;
      "V2.dot product",          `Quick, V2_test.dotproduct;
      "V2.magnitude",            `Quick, V2_test.magnitude;
      "V2.magnitude3",           `Quick, V2_test.magnitude3;
      "V2.magnitude0",           `Quick, V2_test.magnitude0;
      "V2.magnitude2",           `Quick, V2_test.magnitude2;
      "V2.magnitude2_2",         `Quick, V2_test.magnitude2_2;
      "V2.magnitude2_0",         `Quick, V2_test.magnitude2_0;
      "V2.normalize",            `Quick, V2_test.normalize;
      "V2.normalize2",           `Quick, V2_test.normalize2;
      "V2.normalize0",           `Quick, V2_test.normalize0;
      "V2.to_string",            `Quick, V2_test.to_string;
    ];
    "Vector3", [
      (* 3D Vectors *)
      "V3.create",               `Quick, V3_test.create;
      "V3.x",                    `Quick, V3_test.x;
      "V3.y",                    `Quick, V3_test.y;
      "V3.z",                    `Quick, V3_test.z;
      "V3.element",              `Quick, V3_test.el;
      "V3.zero",                 `Quick, V3_test.zero;
      "V3.unitx",                `Quick, V3_test.unitx;
      "V3.unity",                `Quick, V3_test.unity;
      "V3.unitz",                `Quick, V3_test.unitz;
      "V3.invert",               `Quick, V3_test.invert;
      "V3.neg",                  `Quick, V3_test.neg;
      "V3.add",                  `Quick, V3_test.add;
      "V3.op_add",               `Quick, V3_test.op_add;
      "V3.sub",                  `Quick, V3_test.sub;
      "V3.op_sub",               `Quick, V3_test.op_sub;
      "V3.eq",                   `Quick, V3_test.eq;
      "V3.op_eq",                `Quick, V3_test.op_eq;
      "V3.smul",                 `Quick, V3_test.smul;
      "V3.op_smul",              `Quick, V3_test.op_smul;
      "V3.opposite",             `Quick, V3_test.opposite;
      "V3.opposite failure",     `Quick, V3_test.opposite_failure;
      "V3.dot product",          `Quick, V3_test.dotproduct;
      "V3.cross product",        `Quick, V3_test.crossproduct;
      "V3.cross product2",       `Quick, V3_test.crossproduct2;
      "V3.magnitude",            `Quick, V3_test.magnitude;
      "V3.magnitude3",           `Quick, V3_test.magnitude3;
      "V3.magnitude0",           `Quick, V3_test.magnitude0;
      "V3.magnitude2",           `Quick, V3_test.magnitude2;
      "V3.magnitude2_2",         `Quick, V3_test.magnitude2_2;
      "V3.magnitude2_0",         `Quick, V3_test.magnitude2_0;
      "V3.normalize",            `Quick, V3_test.normalize;
      "V3.normalize2",           `Quick, V3_test.normalize2;
      "V3.normalize0",           `Quick, V3_test.normalize0;
      "V3.to_string",            `Quick, V3_test.to_string;
    ];
    "Vector4", [
      (* 4D Vectors *)
      "V4.create",               `Quick, V4_test.create;
      "V4.x",                    `Quick, V4_test.x;
      "V4.y",                    `Quick, V4_test.y;
      "V4.z",                    `Quick, V4_test.z;
      "V4.w",                    `Quick, V4_test.w;
      "V4.element",              `Quick, V4_test.el;
      "V4.zero",                 `Quick, V4_test.zero;
      "V4.unitx",                `Quick, V4_test.unitx;
      "V4.unity",                `Quick, V4_test.unity;
      "V4.unitz",                `Quick, V4_test.unitz;
      "V4.unitw",                `Quick, V4_test.unitw;
      "V4.invert",               `Quick, V4_test.invert;
      "V4.neg",                  `Quick, V4_test.neg;
      "V4.add",                  `Quick, V4_test.add;
      "V4.op_add",               `Quick, V4_test.op_add;
      "V4.sub",                  `Quick, V4_test.sub;
      "V4.op_sub",               `Quick, V4_test.op_sub;
      "V4.eq",                   `Quick, V4_test.eq;
      "V4.op_eq",                `Quick, V4_test.op_eq;
      "V4.smul",                 `Quick, V4_test.smul;
      "V4.op_smul",              `Quick, V4_test.op_smul;
      "V4.opposite",             `Quick, V4_test.opposite;
      "V4.opposite failure",     `Quick, V4_test.opposite_failure;
      "V4.dot product",          `Quick, V4_test.dotproduct;
      "V4.magnitude",            `Quick, V4_test.magnitude;
      "V4.magnitude0",           `Quick, V4_test.magnitude0;
      "V4.magnitude2",           `Quick, V4_test.magnitude2;
      "V4.magnitude3",           `Quick, V4_test.magnitude3;
      "V4.magnitude2_2",         `Quick, V4_test.magnitude2_2;
      "V4.magnitude2_0",         `Quick, V4_test.magnitude2_0;
      "V4.normalize",            `Quick, V4_test.normalize;
      "V4.normalize2",           `Quick, V4_test.normalize2;
      "V4.normalize0",           `Quick, V4_test.normalize0;
      "V4.to_string",            `Quick, V4_test.to_string;
    ];
    "Point2", [
      (* 2D Points *)
      "P2.create",               `Quick, P2_test.create;
      "P2.x",                    `Quick, P2_test.x;
      "P2.y",                    `Quick, P2_test.y;
      "P2.element",              `Quick, P2_test.el;
      "P2.zero",                 `Quick, P2_test.zero;
      "P2.eq",                   `Quick, P2_test.eq;
      "P2.op_eq",                `Quick, P2_test.op_eq;
      "P2.mid",                  `Quick, P2_test.mid;
      "P2.distance",             `Quick, P2_test.distance;
      "P2.to_string",            `Quick, P2_test.to_string;
    ];
    "Point3", [
      (* 3D Points *)
      "P3.create",               `Quick, P3_test.create;
      "P3.x",                    `Quick, P3_test.x;
      "P3.y",                    `Quick, P3_test.y;
      "P3.z",                    `Quick, P3_test.z;
      "P3.element",              `Quick, P3_test.el;
      "P3.zero",                 `Quick, P3_test.zero;
      "P3.eq",                   `Quick, P3_test.eq;
      "P3.op_eq",                `Quick, P3_test.op_eq;
      "P3.mid",                  `Quick, P3_test.mid;
      "P3.distance",             `Quick, P3_test.distance;
      "P3.to_string",            `Quick, P3_test.to_string;
    ];
    "Matrix2", [
      (* 2x2 Matrices *)
      "M2.create",               `Quick, M2_test.create;
      "M2.e00",                  `Quick, M2_test.e00;
      "M2.e01",                  `Quick, M2_test.e01;
      "M2.e10",                  `Quick, M2_test.e10;
      "M2.e11",                  `Quick, M2_test.e11;
      "M2.zero",                 `Quick, M2_test.zero;
      "M2.id",                   `Quick, M2_test.id;
      "M2.el",                   `Quick, M2_test.el;
      "M2.neg",                  `Quick, M2_test.neg;
      "M2.add",                  `Quick, M2_test.add;
      "M2.op_add",               `Quick, M2_test.op_add;
      "M2.sub",                  `Quick, M2_test.sub;
      "M2.op_sub",               `Quick, M2_test.op_sub;
      "M2.eq",                   `Quick, M2_test.eq;
      "M2.op_eq",                `Quick, M2_test.op_eq;
      "M2.smul",                 `Quick, M2_test.smul;
      "M2.transpose",            `Quick, M2_test.transpose;
      "M2.mul",                  `Quick, M2_test.mul;
      "M2.op_mul",               `Quick, M2_test.op_mul;
      "M2.emul",                 `Quick, M2_test.emul;
      "M2.ediv",                 `Quick, M2_test.ediv;
      "M2.det",                  `Quick, M2_test.det;
      "M2.trace",                `Quick, M2_test.trace;
      "M2.inverse",              `Quick, M2_test.inverse;
      "M2.to_string",            `Quick, M2_test.to_string;
    ];
    "Matrix3", [
      (* 3x3 Matrices *)
      "M3.create",               `Quick, M3_test.create;
      "M3.e00",                  `Quick, M3_test.e00;
      "M3.e01",                  `Quick, M3_test.e01;
      "M3.e02",                  `Quick, M3_test.e02;
      "M3.e10",                  `Quick, M3_test.e10;
      "M3.e11",                  `Quick, M3_test.e11;
      "M3.e12",                  `Quick, M3_test.e12;
      "M3.e20",                  `Quick, M3_test.e20;
      "M3.e21",                  `Quick, M3_test.e21;
      "M3.e22",                  `Quick, M3_test.e22;
      "M3.zero",                 `Quick, M3_test.zero;
      "M3.id",                   `Quick, M3_test.id;
      "M3.el",                   `Quick, M3_test.el;
      "M3.neg",                  `Quick, M3_test.neg;
      "M3.add",                  `Quick, M3_test.add;
      "M3.op_add",               `Quick, M3_test.op_add;
      "M3.sub",                  `Quick, M3_test.sub;
      "M3.op_sub",               `Quick, M3_test.op_sub;
      "M3.eq",                   `Quick, M3_test.eq;
      "M3.op_eq",                `Quick, M3_test.op_eq;
      "M3.smul",                 `Quick, M3_test.smul;
      "M3.transpose",            `Quick, M3_test.transpose;
      "M3.mul",                  `Quick, M3_test.mul;
      "M3.op_mul",               `Quick, M3_test.op_mul;
      "M3.emul",                 `Quick, M3_test.emul;
      "M3.ediv",                 `Quick, M3_test.ediv;
      "M3.det",                  `Quick, M3_test.det;
      "M3.trace",                `Quick, M3_test.trace;
      "M3.inverse",              `Quick, M3_test.inverse;
      "M3.to_string",            `Quick, M3_test.to_string;
    ];
    "Quaternion", [
      (* Quaternions *)
      "Q.create",                `Quick, Q_test.create;
      "Q.r",                     `Quick, Q_test.r;
      "Q.a",                     `Quick, Q_test.a;
      "Q.b",                     `Quick, Q_test.b;
      "Q.c",                     `Quick, Q_test.c;
      "Q.zero",                  `Quick, Q_test.zero;
      "Q.real",                  `Quick, Q_test.real;
      "Q.imag",                  `Quick, Q_test.imag;
      "Q.of_scalar",             `Quick, Q_test.of_scalar;
      "Q.to_list",               `Quick, Q_test.to_list;
      "Q.of_list",               `Quick, Q_test.of_list;
      "Q.conj",                  `Quick, Q_test.conj;
      "Q.smul",                  `Quick, Q_test.smul;
      "Q.sdiv",                  `Quick, Q_test.sdiv;
      "Q.norm2",                 `Quick, Q_test.norm2;
      "Q.magnitude",             `Quick, Q_test.magnitude;
      "Q.length",                `Quick, Q_test.length;
      "Q.norm",                  `Quick, Q_test.norm;
      "Q.inv",                   `Quick, Q_test.inv;
      "Q.add",                   `Quick, Q_test.add;
      "Q.sub",                   `Quick, Q_test.sub;
      "Q.mul",                   `Quick, Q_test.mul;
      "Q.div",                   `Quick, Q_test.div;
      "Q.pow",                   `Quick, Q_test.pow;
      "Q.op_add",                `Quick, Q_test.op_add;
      "Q.op_sub",                `Quick, Q_test.op_sub;
      "Q.op_mul",                `Quick, Q_test.op_mul;
      "Q.op_div",                `Quick, Q_test.op_div;
      "Q.op_exp",                `Quick, Q_test.op_exp;
      "Q.eq",                    `Quick, Q_test.eq;
      "Q.op_eq",                 `Quick, Q_test.op_eq;
      "Q.addr",                  `Quick, Q_test.addr;
      "Q.subr",                  `Quick, Q_test.subr;
      "Q.mulr",                  `Quick, Q_test.mulr;
      "Q.divr",                  `Quick, Q_test.divr;
      "Q.neg",                   `Quick, Q_test.neg;
      "Q.unit",                  `Quick, Q_test.unit;
      "Q.dot",                   `Quick, Q_test.dot;
      "Q.cos_alpha",             `Quick, Q_test.cos_alpha;
      "Q.alpha",                 `Quick, Q_test.alpha;
      "Q.distance",              `Quick, Q_test.distance;
      "Q.slerp",                 `Quick, Q_test.slerp;
      "Q.squad",                 `Quick, Q_test.squad;
      "Q.nlerp",                 `Quick, Q_test.nlerp;
      "Q.exp",                   `Quick, Q_test.exp;
      "Q.log",                   `Quick, Q_test.log;
      "Q.to_string",             `Quick, Q_test.to_string;
    ];
  ]

