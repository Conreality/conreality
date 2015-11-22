(* This is free and unencumbered software released into the public domain. *)

open Check_common
open Consensus.Knowledge

(* Knowledge.Term *)

module Term_test = struct
  open Term

  let uri_term = Term.make_uri "http://example.org"

  let uuid_term = Term.make_uuid "8a11730e-f2c5-4ae5-b2ee-fe02718213fa"

  let node_term = Term.make_node "foobar"

  let make_uri = todo

  let make_uuid = todo

  let make_node = todo
end

(* Knowledge.Fact *)

module Fact_test = struct
  open Fact

  let create = todo

  let subject = todo

  let predicate = todo

  let object_ = todo

  let confidence = todo
end

(* Knowledge.Rule *)

module Rule_test = struct
  open Rule

  (* TODO *)
end

(* Test suite definition *)

let () =
  Alcotest.run "Consensus.Knowledge test suite" [
    "Term", [
      "Term.make_uri",   `Quick, Term_test.make_uri;
      "Term.make_uuid",  `Quick, Term_test.make_uuid;
      "Term.make_node",  `Quick, Term_test.make_node;
    ];
    "Fact", [
      "Fact.create",     `Quick, Fact_test.create;
      "Fact.subject",    `Quick, Fact_test.subject;
      "Fact.predicate",  `Quick, Fact_test.predicate;
      "Fact.object",     `Quick, Fact_test.object_;
      "Fact.confidence", `Quick, Fact_test.confidence;
    ];
    "Rule", [
      (* TODO *)
    ];
  ]
