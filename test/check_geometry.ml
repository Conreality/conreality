(* This is free and unencumbered software released into the public domain. *)

open Check_common
open Consensus.Geometry

(* TODO: Use prelude_math *)
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

end

module M2_test = struct
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
  let smul () = todo ()
  let transpose () = todo ()
  let mul () = todo ()
  let op_mul () = todo ()
  let emul () = todo ()
  let ediv () = todo ()
  let det () = todo ()
  let trace () = todo ()
  let inverse () = todo ()

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
    ];
    "Matrix2", [
      (* 2D Matrices *)
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
    ];
  ]

