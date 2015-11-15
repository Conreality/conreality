(* This is free and unencumbered software released into the public domain. *)

open Consensus.Messaging

let abc_topic = Topic.create ["a"; "b"; "c"]

let topic_create () =
  Alcotest.(check (list string)) "string list"
    ["a"; "b"; "c"]
    (Topic.path abc_topic)

let topic_to_string () =
  Alcotest.(check string) "string"
    "a/b/c"
    (Topic.to_string abc_topic)

let () =
  Alcotest.run "Messaging test suite" [
    "test_topic", [
      "Topic.create",    `Quick, topic_create;
      "Topic.to_string", `Quick, topic_to_string;
    ];
  ]
