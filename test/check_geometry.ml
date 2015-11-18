(* This is free and unencumbered software released into the public domain. *)

open Consensus.Geometry
open Check_common

let e = 2.71828
let pi = 3.14159
let phi = 1.61803

(* 3D Vectors *)

let tvec2_1 = V2.create (3.) (1.)
let tvec2_1opposite = V2.create (-3.) (-1.)
let tvec2_2 = V2.create e pi
let tvec2_0 = V2.zero
let make_v2 x = V2.create (x) (x)

let v2_to_list v = [(V2.x v); (V2.y v)]
(* Keep this one operating on floats to avoid depending on V2.eq *)
let v2_create () = Alcotest.(check (list float)) "float list" [e; pi] (v2_to_list tvec2_2)
let v2_x () = same_float 3. (V2.x tvec2_1)
let v2_y () = same_float pi (V2.y tvec2_2)
let v2_el () = same_float 3. (V2.el tvec2_1 0)
(* Keep this one operating on floats to avoid depending on V2.eq *)
let v2_zero () = Alcotest.(check (list float)) "float list" [0.; 0.] (v2_to_list tvec2_0)
let v2_unitx () = same_bool true (V2.eq V2.unitx (V2.create 1. 0.))
let v2_unity () = same_bool true (V2.eq V2.unity (V2.create 0. 1.))
let v2_invert () = same_bool true (V2.eq tvec2_1opposite (V2.invert tvec2_1))
let v2_neg () = same_bool true (V2.eq tvec2_1opposite (V2.neg tvec2_1))

let v2_add_expected = V2.create (5.71828) (4.14159)
let v2_add () =
  let v = V2.add tvec2_1 tvec2_2 in
  same_bool true (V2.eq v v2_add_expected)
let v2_op_add () =
  let v = V2.( + ) tvec2_1 tvec2_2 in
  same_bool true (V2.eq v v2_add_expected)

let v2_sub_expected = V2.create (0.28172) (-2.14159)
let v2_sub () =
  let v = V2.sub tvec2_1 tvec2_2 in
  same_bool true (V2.eq v v2_sub_expected)
let v2_op_sub () =
  let v = V2.( - ) tvec2_1 tvec2_2 in
  same_bool true (V2.eq v v2_sub_expected)

let v2_eq () = same_bool true (V2.eq V2.zero V2.zero)
let v2_op_eq () = same_bool true (V2.zero = V2.zero)

let v2_smul_expected = V2.create (6.) (2.)
let v2_smul () =
  let v = V2.smul tvec2_1 2. in
  same_bool true (V2.eq v v2_smul_expected)
let v2_op_smul () =
  let v = V2.( * ) tvec2_1 2. in
  same_bool true (V2.eq v v2_smul_expected)

let v2_opposite () = same_bool true (V2.opposite tvec2_1 tvec2_1opposite)
let v2_opposite_failure () = same_bool false (V2.opposite tvec2_1 tvec2_2)
let v2_dotproduct () = same_float 11.29643 (V2.dotproduct tvec2_1 tvec2_2)
let v2_magnitude () = same_float 3.16227766 (V2.magnitude tvec2_1)
let v2_magnitude2 () = same_float 10. (V2.magnitude2 tvec2_1)
let v2_magnitude2_2 () = same_float 17.258633887 (V2.magnitude2 tvec2_2)
let v2_magnitude3 () = same_float 4.154351199 (V2.magnitude tvec2_2)
let v2_magnitude2_0 () = same_float 0. (V2.magnitude2 tvec2_0)
let v2_magnitude0 () = same_float 0. (V2.magnitude tvec2_0)

let v2_normalize () =
(* normalize v = v.x / magnitude v, v.y / magnitude v *)
(* magnitude 3 1 = 3.16227766 *)
(* normalize 3 1 = 0.948683298 0.316227766 *)
  let v = V2.normalize tvec2_1 in
  let vn = V2.create (0.948683298) (0.316227766) in
  same_bool true (V2.eq v vn)

let v2_normalize2 () =
(* magnitude 2.71828 3.14159 = 4.154351199 *)
(* normalize 2.71828 3.14159 = 0.654321185 0.704657139 *)
  let v = V2.normalize tvec2_2 in
  let vn = V2.create (0.654321185) (0.756216759) in
  same_bool true (V2.eq v vn)

let v2_normalize0 () =
  same_bool true (V2.eq tvec2_0 (V2.normalize tvec2_0))

(* 3D Vectors *)

let tvec3_1 = V3.create (3.) (1.) (2.)
let tvec3_1opposite = V3.create (-3.) (-1.) (-2.)
let tvec3_2 = V3.create e pi phi
let tvec3_0 = V3.zero
let make_v3 x = V3.create (x) (x) (x)

let v3_to_list v = [(V3.x v); (V3.y v); (V3.z v)]
(* Keep this one operating on floats to avoid depending on V3.eq *)
let v3_create () = Alcotest.(check (list float)) "float list" [e; pi; phi] (v3_to_list tvec3_2)
let v3_x () = same_float 3. (V3.x tvec3_1)
let v3_y () = same_float pi (V3.y tvec3_2)
let v3_z () = same_float 2. (V3.z tvec3_1)
let v3_el () = same_float 3. (V3.el tvec3_1 0)
(* Keep this one operating on floats to avoid depending on V3.eq *)
let v3_zero () = Alcotest.(check (list float)) "float list" [0.; 0.; 0.] (v3_to_list tvec3_0)
let v3_unitx () = same_bool true (V3.eq V3.unitx (V3.create 1. 0. 0.))
let v3_unity () = same_bool true (V3.eq V3.unity (V3.create 0. 1. 0.))
let v3_unitz () = same_bool true (V3.eq V3.unitz (V3.create 0. 0. 1.))
let v3_invert () = same_bool true (V3.eq tvec3_1opposite (V3.invert tvec3_1))
let v3_neg () = same_bool true (V3.eq tvec3_1opposite (V3.neg tvec3_1))

let v3_add_expected = V3.create (5.71828) (4.14159) (3.61803)
let v3_add () =
  let v = V3.add tvec3_1 tvec3_2 in
  same_bool true (V3.eq v v3_add_expected)
let v3_op_add () =
  let v = V3.( + ) tvec3_1 tvec3_2 in
  same_bool true (V3.eq v v3_add_expected)

let v3_sub_expected = V3.create (0.28172) (-2.14159) (0.38197)
let v3_sub () =
  let v = V3.sub tvec3_1 tvec3_2 in
  same_bool true (V3.eq v v3_sub_expected)
let v3_op_sub () =
  let v = V3.( - ) tvec3_1 tvec3_2 in
  same_bool true (V3.eq v v3_sub_expected)

let v3_eq () = same_bool true (V3.eq V3.zero V3.zero)
let v3_op_eq () = same_bool true (V3.zero = V3.zero)

let v3_smul_expected = V3.create (6.) (2.) (4.)
let v3_smul () =
  let v = V3.smul tvec3_1 2. in
  same_bool true (V3.eq v v3_smul_expected)
let v3_op_smul () =
  let v = V3.( * ) tvec3_1 2. in
  same_bool true (V3.eq v v3_smul_expected)

let v3_opposite () = same_bool true (V3.opposite tvec3_1 tvec3_1opposite)
let v3_opposite_failure () = same_bool false (V3.opposite tvec3_1 tvec3_2)

let v3_dotproduct () = same_float 14.53249 (V3.dotproduct tvec3_1 tvec3_2)

let v3_crossproduct () =
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
let v3_crossproduct2 () =
  same_bool true (V3.eq vx wx)

let v3_magnitude () = same_float 3.741657387 (V3.magnitude tvec3_1)
let v3_magnitude2 () = same_float 14. (V3.magnitude2 tvec3_1)
let v3_magnitude2_2 () = same_float 19.876654967 (V3.magnitude2 tvec3_2)
let v3_magnitude3 () = same_float 4.458324233 (V3.magnitude tvec3_2)
let v3_magnitude2_0 () = same_float 0. (V3.magnitude2 tvec3_0)
let v3_magnitude0 () = same_float 0. (V3.magnitude tvec3_0)

let v3_normalize () =
(* normalize v = v.x / magnitude v, v.y / magnitude v, v.z / magnitude z  *)
(* magnitude 3 1 2 = 3.741657387 *)
(* normalize 3 1 2 = 0.801783726 0.267261242 0.534522484 *)
  let v = V3.normalize tvec3_1 in
  let vn = V3.create (0.801783726) (0.267261242) (0.534522484) in
  same_bool true (V3.eq v vn)

let v3_normalize2 () =
(* magnitude 2.71828 3.14159 1.61803 = 4.458324233 *)
(* normalize 2.71828 3.14159 1.61803 = 0.609708908 0.704657139 0.362923358 *)
  let v = V3.normalize tvec3_2 in
  let vn = V3.create (0.609708908) (0.704657139) (0.362923358) in
  same_bool true (V3.eq v vn)

let v3_normalize0 () =
  same_bool true (V3.eq tvec3_0 (V3.normalize tvec3_0))

(* 2D Points *)

let tp2_1 = P2.create (3.) (1.)
let tp2_2 = P2.create (e) (pi)
let tp2_zero = P2.zero

let p2_to_list p = [ (P2.x p); (P2.y p); ]
(* Keep this one operating on floats to avoid depending on P2.eq *)
let p2_create () = Alcotest.(check (list float)) "float list" [e; pi] (p2_to_list tp2_2)
let p2_x () = same_float 3. (P2.x tp2_1)
let p2_y () = same_float pi (P2.y tp2_2)
let p2_el () = same_float 3. (P2.el tp2_1 0)
(* Keep this one operating on floats to avoid depending on P2.eq *)
let p2_zero () = Alcotest.(check (list float)) "float list" [0.; 0.] (p2_to_list tp2_zero)
let p2_eq () = same_bool true (P2.eq P2.zero P2.zero)
let p2_op_eq () = same_bool true (P2.zero = P2.zero)
let p2_mid () = same_bool true ((P2.mid tp2_1 tp2_zero) = (P2.create (1.5) (0.5)))
let p2_distance () = same_float 3.16227766 (P2.distance tp2_1 tp2_zero)

(* 2D Points *)

let tp3_1 = P3.create (3.) (1.) (2.)
let tp3_2 = P3.create (e) (pi) (phi)
let tp3_zero = P3.zero

let p3_to_list p = [ (P3.x p); (P3.y p); (P3.z p) ]
(* Keep this one operating on floats to avoid depending on P3.eq *)
let p3_create () = Alcotest.(check (list float)) "float list" [e; pi; phi] (p3_to_list tp3_2)
let p3_x () = same_float 3. (P3.x tp3_1)
let p3_y () = same_float pi (P3.y tp3_2)
let p3_z () = same_float 2. (P3.z tp3_1)
let p3_el () = same_float 3. (P3.el tp3_1 0)
(* Keep this one operating on floats to avoid depending on P3.eq *)
let p3_zero () = Alcotest.(check (list float)) "float list" [0.; 0.; 0.] (p3_to_list tp3_zero)
let p3_eq () = same_bool true (P3.eq P3.zero P3.zero)
let p3_op_eq () = same_bool true (P3.zero = P3.zero)
let p3_mid () = same_bool true ((P3.mid tp3_1 tp3_zero) = (P3.create (1.5) (0.5) (1.0)))
let p3_distance () = same_float 3.741657387 (P3.distance tp3_1 tp3_zero)

(* 2D Matrices *)

let tm2_1 = M2.create
    (3.) (1.)
    (2.) (7.)
let tm2_2 = M2.create
    (e) (pi)
    (phi) (0.)
let tm2_zero = M2.zero

let m2_to_list m = [ (M2.e00 m); (M2.e01 m); (M2.e10 m); (M2.e11 m) ]
(* Keep this one operating on floats to avoid depending on P3.eq *)
let m2_create () = Alcotest.(check (list float)) "float list" [e; pi; phi; 0.] (m2_to_list tm2_2)
let m2_e00 () = same_float e (M2.e00 tm2_2)
let m2_e01 () = same_float pi (M2.e01 tm2_2)
let m2_e10 () = same_float phi (M2.e10 tm2_2)
let m2_e11 () = same_float 0. (M2.e11 tm2_2)
(* Keep this one operating on floats to avoid depending on P3.eq *)
let m2_zero () = Alcotest.(check (list float)) "float list" [0.; 0.; 0.; 0.] (m2_to_list tm2_zero)
let m2_id () = Alcotest.(check (list float)) "float list" [1.; 0.; 0.; 1.] (m2_to_list M2.id)
let m2_el () = same_float 3.14159 (M2.e01 tm2_2)
let m2_neg () = todo ()
let m2_add () = todo ()
let m2_op_add () = todo ()
let m2_sub () = todo ()
let m2_op_sub () = todo ()
let m2_eq () = same_bool true (M2.eq M2.zero M2.zero)
let m2_op_eq () = same_bool true (M2.zero = M2.zero)
let m2_smul () = todo ()
let m2_transpose () = todo ()
let m2_mul () = todo ()
let m2_op_mul () = todo ()
let m2_emul () = todo ()
let m2_ediv () = todo ()
let m2_det () = todo ()
let m2_trace () = todo ()
let m2_inverse () = todo ()

let () =
  Alcotest.run "My first test" [
    "test_set", [
      (* 2D Vectors *)
      "v2 create",               `Quick, v2_create;
      "v2 x",                    `Quick, v2_x;
      "v2 y",                    `Quick, v2_y;
      "v2 element",              `Quick, v2_el;
      "v2 zero",                 `Quick, v2_zero;
      "v2 unitx",                `Quick, v2_unitx;
      "v2 unity",                `Quick, v2_unity;
      "v2 invert",               `Quick, v2_invert;
      "v2 neg",                  `Quick, v2_neg;
      "v2 add",                  `Quick, v2_add;
      "v2 op_add",               `Quick, v2_op_add;
      "v2 sub",                  `Quick, v2_sub;
      "v2 op_sub",               `Quick, v2_op_sub;
      "v2 eq",                   `Quick, v2_eq;
      "v2 op_eq",                `Quick, v2_op_eq;
      "v2 smul",                 `Quick, v2_smul;
      "v2 op_smul",              `Quick, v2_op_smul;
      "v2 opposite",             `Quick, v2_opposite;
      "v2 opposite failure",     `Quick, v2_opposite_failure;
      "v2 dot product",          `Quick, v2_dotproduct;
      "v2 magnitude",            `Quick, v2_magnitude;
      "v2 magnitude3",           `Quick, v2_magnitude3;
      "v2 magnitude0",           `Quick, v2_magnitude0;
      "v2 magnitude2",           `Quick, v2_magnitude2;
      "v2 magnitude2_2",         `Quick, v2_magnitude2_2;
      "v2 magnitude2_0",         `Quick, v2_magnitude2_0;
      "v2 normalize",            `Quick, v2_normalize;
      "v2 normalize2",           `Quick, v2_normalize2;
      "v2 normalize0",           `Quick, v2_normalize0;
      (* 3D Vectors *)
      "v3 create",               `Quick, v3_create;
      "v3 x",                    `Quick, v3_x;
      "v3 y",                    `Quick, v3_y;
      "v3 z",                    `Quick, v3_z;
      "v3 element",              `Quick, v3_el;
      "v3 zero",                 `Quick, v3_zero;
      "v3 unitx",                `Quick, v3_unitx;
      "v3 unity",                `Quick, v3_unity;
      "v3 unitz",                `Quick, v3_unitz;
      "v3 invert",               `Quick, v3_invert;
      "v3 neg",                  `Quick, v3_neg;
      "v3 add",                  `Quick, v3_add;
      "v3 op_add",               `Quick, v3_op_add;
      "v3 sub",                  `Quick, v3_sub;
      "v3 op_sub",               `Quick, v3_op_sub;
      "v3 eq",                   `Quick, v3_eq;
      "v3 op_eq",                `Quick, v3_op_eq;
      "v3 smul",                 `Quick, v3_smul;
      "v3 op_smul",              `Quick, v3_op_smul;
      "v3 opposite",             `Quick, v3_opposite;
      "v3 opposite failure",     `Quick, v3_opposite_failure;
      "v3 dot product",          `Quick, v3_dotproduct;
      "v3 cross product",        `Quick, v3_crossproduct;
      "v3 cross product2",       `Quick, v3_crossproduct2;
      "v3 magnitude",            `Quick, v3_magnitude;
      "v3 magnitude3",           `Quick, v3_magnitude3;
      "v3 magnitude0",           `Quick, v3_magnitude0;
      "v3 magnitude2",           `Quick, v3_magnitude2;
      "v3 magnitude2_2",         `Quick, v3_magnitude2_2;
      "v3 magnitude2_0",         `Quick, v3_magnitude2_0;
      "v3 normalize",            `Quick, v3_normalize;
      "v3 normalize2",           `Quick, v3_normalize2;
      "v3 normalize0",           `Quick, v3_normalize0;
      (* 2D Points *)
      "p2 create",               `Quick, p2_create;
      "p2 x",                    `Quick, p2_x;
      "p2 y",                    `Quick, p2_y;
      "p2 element",              `Quick, p2_el;
      "p2 zero",                 `Quick, p2_zero;
      "p2 eq",                   `Quick, p2_eq;
      "p2 op_eq",                `Quick, p2_op_eq;
      "p2 mid",                  `Quick, p2_mid;
      "p2 distance",             `Quick, p2_distance;
      (* 3D Points *)
      "p3 create",               `Quick, p3_create;
      "p3 x",                    `Quick, p3_x;
      "p3 y",                    `Quick, p3_y;
      "p3 z",                    `Quick, p3_z;
      "p3 element",              `Quick, p3_el;
      "p3 zero",                 `Quick, p3_zero;
      "p3 eq",                   `Quick, p3_eq;
      "p3 op_eq",                `Quick, p3_op_eq;
      "p3 mid",                  `Quick, p3_mid;
      "p3 distance",             `Quick, p3_distance;
      (* 2D Matrices *)
      "m2_create",               `Quick, m2_create;
      "m2_e00",                  `Quick, m2_e00;
      "m2_e01",                  `Quick, m2_e01;
      "m2_e10",                  `Quick, m2_e10;
      "m2_e11",                  `Quick, m2_e11;
      "m2_zero",                 `Quick, m2_zero;
      "m2_id",                   `Quick, m2_id;
      "m2_el",                   `Quick, m2_el;
      "m2_neg",                  `Quick, m2_neg;
      "m2_add",                  `Quick, m2_add;
      "m2_op_add",               `Quick, m2_op_add;
      "m2_sub",                  `Quick, m2_sub;
      "m2_op_sub",               `Quick, m2_op_sub;
      "m2_eq",                   `Quick, m2_eq;
      "m2_op_eq",                `Quick, m2_op_eq;
      "m2_smul",                 `Quick, m2_smul;
      "m2_transpose",            `Quick, m2_transpose;
      "m2_mul",                  `Quick, m2_mul;
      "m2_op_mul",               `Quick, m2_op_mul;
      "m2_emul",                 `Quick, m2_emul;
      "m2_ediv",                 `Quick, m2_ediv;
      "m2_det",                  `Quick, m2_det;
      "m2_trace",                `Quick, m2_trace;
      "m2_inverse",              `Quick, m2_inverse;
    ];
  ]

