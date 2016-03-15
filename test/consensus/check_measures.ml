(* This is free and unencumbered software released into the public domain. *)

open Check_common
open Consensus.Measures

(* Measures.Length *)

module Length_test = struct
  let value = Length (1., meter)

  (* TODO *)
end

(* Measures.Mass *)

module Mass_test = struct
  let value = Mass (1., kilogram)

  (* TODO *)
end

(* Measures.Time *)

module Time_test = struct
  let value = Time (1., second)

  (* TODO *)
end

(* Measures.Current *)

module Current_test = struct
  let value = Current (1., ampere)

  (* TODO *)
end

(* Measures.Temperature *)

module Temperature_test = struct
  let value = Temperature (1., kelvin)

  (* TODO *)
end

(* Test suite definition *)

let () =
  Alcotest.run "Consensus.Measures test suite" [
    "Length", [
      (* TODO *)
    ];
    "Mass", [
      (* TODO *)
    ];
    "Time", [
      (* TODO *)
    ];
    "Current", [
      (* TODO *)
    ];
    "Temperature", [
      (* TODO *)
    ];
  ]
