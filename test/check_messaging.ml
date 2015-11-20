(* This is free and unencumbered software released into the public domain. *)

open Check_common
open Consensus.Messaging

(* Messaging.Topic *)

module Topic_test = struct
  open Topic

  let abc_topic = Topic.create ["a"; "b"; "c"]

  let create () =
    Alcotest.(check (list string)) "string list"
      ["a"; "b"; "c"] (Topic.path abc_topic) (* FIXME: don't use Topic.path here *)

  let of_string () =
    Alcotest.(check (list string)) "string list"
      ["a"; "b"; "c"] (Topic.path (Topic.of_string "a/b/c"))

  let to_string () =
    Alcotest.(check string) "string"
      "a/b/c" (Topic.to_string abc_topic)

  let path () =
    Alcotest.(check (list string)) "string list"
      ["a"; "b"; "c"] (Topic.path abc_topic)

  let message_type () =
    Alcotest.(check string) "string"
      "" (Topic.message_type abc_topic)

  let qos_policy () =
    Alcotest.(check int) "string"
      0 (Topic.qos_policy abc_topic)
end

(* Messaging.Stomp_frame *)

module Stomp_frame_test = struct
  open Stomp_frame

  let message_frame =
    Stomp_frame.create "MESSAGE" ["key1:value1"; "key2:value2"] "body"

  let create () = todo ()

  let to_string () =
    Alcotest.(check string) "string"
      "MESSAGE\nkey1:value1\nkey2:value2\n\nbody\x00"
      (Stomp_frame.to_string message_frame)

  let command () = todo ()

  let headers () = todo ()

  let body () = todo ()
end

(* Test suite definition *)

let () =
  Alcotest.run "Consensus.Messaging test suite" [
    "Topic", [
      "Topic.create",          `Quick, Topic_test.create;
      (* XXX: Temporarily disabled *)
      (*"Topic.of_string",       `Quick, Topic_test.of_string;*)
      "Topic.to_string",       `Quick, Topic_test.to_string;
      "Topic.path",            `Quick, Topic_test.path;
      "Topic.message_type",    `Quick, Topic_test.message_type;
      "Topic.qos_policy",      `Quick, Topic_test.qos_policy;
    ];
    "Stomp_frame", [
      "Stomp_frame.create",    `Quick, Stomp_frame_test.create;
      "Stomp_frame.to_string", `Quick, Stomp_frame_test.to_string;
      "Stomp_frame.command",   `Quick, Stomp_frame_test.command;
      "Stomp_frame.headers",   `Quick, Stomp_frame_test.headers;
      "Stomp_frame.body",      `Quick, Stomp_frame_test.body;
    ];
  ]
