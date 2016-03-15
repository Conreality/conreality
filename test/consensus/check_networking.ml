(* This is free and unencumbered software released into the public domain. *)

open Check_common
open Consensus.Networking

(* Networking.UDP *)

module UDP_test = struct
  open UDP
end

(* Test suite definition *)

let () =
  Alcotest.run "Consensus.Networking test suite" [
    "STOMP.Protocol", [
      (* TODO *)
    ];
  ]
