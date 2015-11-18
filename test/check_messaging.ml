(* This is free and unencumbered software released into the public domain. *)

open Consensus.Messaging

let abc_topic = Topic.create ["a"; "b"; "c"]

let topic_create () =
  Alcotest.(check (list string)) "string list"
    ["a"; "b"; "c"] (Topic.path abc_topic) (* FIXME: don't use Topic.path here *)

let topic_of_string () =
  Alcotest.(check (list string)) "string list"
    ["a"; "b"; "c"] (Topic.path (Topic.of_string "a/b/c"))

let topic_to_string () =
  Alcotest.(check string) "string"
    "a/b/c" (Topic.to_string abc_topic)

let topic_path () =
  Alcotest.(check (list string)) "string list"
    ["a"; "b"; "c"] (Topic.path abc_topic)

let topic_message_type () =
  Alcotest.(check string) "string"
    "" (Topic.message_type abc_topic)

let topic_qos_policy () =
  Alcotest.(check int) "string"
    0 (Topic.qos_policy abc_topic)

let () =
  Alcotest.run "Consensus.Messaging test suite" [
    "Topic", [
      "Topic.create",       `Quick, topic_create;
      (* XXX: Temporarily disabled *)
      (*"Topic.of_string",    `Quick, topic_of_string;*)
      "Topic.to_string",    `Quick, topic_to_string;
      "Topic.path",         `Quick, topic_path;
      "Topic.message_type", `Quick, topic_message_type;
      "Topic.qos_policy",   `Quick, topic_qos_policy;
    ];
  ]
