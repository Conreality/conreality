(* This is free and unencumbered software released into the public domain. *)

open Consensus.Geometry
open Check_common

let v3_to_list v = [(V3.x v); (V3.y v); (V3.z v)]

let e = 2.71828
let pi = 3.14159
let phi = 1.61803

let tvec3_1 = V3.create (3.) (1.) (2.)
let tvec3_1opposite = V3.create (-3.) (-1.) (-2.)
let tvec3_2 = V3.create e pi phi
let tvec3_0 = V3.zero
let make_v3 x = V3.create (x) (x) (x)

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
let v3_op_eq () = same_bool true (V3.eq V3.zero V3.zero)

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
let v3_dotproduct2 () = same_float 14. (V3.dotproduct tvec3_1 tvec3_1)

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

(*
let v3_distance () =
(* distance(3 1 2, e pi phi) = 2.193553046 *)
  same_float 2.193553046 (V3.distance tvec3_1 tvec3_2)

let v3_distance0 () =
  same_float 0. (V3.distance tvec3_0 tvec3_0)
*)

let () =
  Alcotest.run "My first test" [
    "test_set", [
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
      "v3 dot product2",         `Quick, v3_dotproduct2;
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
    ];
  ]

