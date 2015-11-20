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

  let path () =
    Alcotest.(check (list string)) "string list"
      ["a"; "b"; "c"] (Topic.path abc_topic)

  let message_type () =
    Alcotest.(check string) "string"
      "" (Topic.message_type abc_topic)

  let qos_policy () =
    Alcotest.(check int) "string"
      0 (Topic.qos_policy abc_topic)

  let of_string () =
    Alcotest.(check (list string)) "string list"
      ["a"; "b"; "c"] (Topic.path (Topic.of_string "a/b/c"))

  let to_string () =
    Alcotest.(check string) "string"
      "a/b/c" (Topic.to_string abc_topic)
end

(* Messaging.Stomp_command *)

module Stomp_command_test = struct
  open Stomp_command

  let connected () =
    Alcotest.(check string) "string"
      "CONNECTED" (Stomp_command.to_string CONNECTED)

  let message () =
    Alcotest.(check string) "string"
      "MESSAGE" (Stomp_command.to_string MESSAGE)

  let receipt () =
    Alcotest.(check string) "string"
      "RECEIPT" (Stomp_command.to_string RECEIPT)

  let error () =
    Alcotest.(check string) "string"
      "ERROR" (Stomp_command.to_string ERROR)

  let connect () =
    Alcotest.(check string) "string"
      "CONNECT" (Stomp_command.to_string CONNECT)

  let send () =
    Alcotest.(check string) "string"
      "SEND" (Stomp_command.to_string SEND)

  let subscribe () =
    Alcotest.(check string) "string"
      "SUBSCRIBE" (Stomp_command.to_string SUBSCRIBE)

  let unsubscribe () =
    Alcotest.(check string) "string"
      "UNSUBSCRIBE" (Stomp_command.to_string UNSUBSCRIBE)

  let ack () =
    Alcotest.(check string) "string"
      "ACK" (Stomp_command.to_string ACK)

  let nack () =
    Alcotest.(check string) "string"
      "NACK" (Stomp_command.to_string NACK)

  let begin_ () =
    Alcotest.(check string) "string"
      "BEGIN" (Stomp_command.to_string BEGIN)

  let commit () =
    Alcotest.(check string) "string"
      "COMMIT" (Stomp_command.to_string COMMIT)

  let abort () =
    Alcotest.(check string) "string"
      "ABORT" (Stomp_command.to_string ABORT)

  let disconnect () =
    Alcotest.(check string) "string"
      "DISCONNECT" (Stomp_command.to_string DISCONNECT)
end

(* Messaging.Stomp_frame *)

module Stomp_frame_test = struct
  open Stomp_frame
  open Stomp_command

  let message_frame =
    Stomp_frame.create MESSAGE ["key1:value1"; "key2:value2"] "body"

  let message_frame_bytes =
    "MESSAGE\nkey1:value1\nkey2:value2\n\nbody\x00"

  let create () = todo ()

  let command () =
    Alcotest.(check string) "string"
      "MESSAGE" (Stomp_command.to_string (Stomp_frame.command message_frame))

  let headers () = todo ()

  let body () =
    Alcotest.(check string) "string"
      "body" (Stomp_frame.body message_frame)

  let size () =
    Alcotest.(check int) "int"
      (String.length message_frame_bytes)
      (Stomp_frame.size message_frame)

  let to_string () =
    Alcotest.(check string) "string"
      message_frame_bytes
      (Stomp_frame.to_string message_frame)
end

(* Test suite definition *)

let () =
  Alcotest.run "Consensus.Messaging test suite" [
    "Topic", [
      "Topic.create",          `Quick, Topic_test.create;
      "Topic.path",            `Quick, Topic_test.path;
      "Topic.message_type",    `Quick, Topic_test.message_type;
      "Topic.qos_policy",      `Quick, Topic_test.qos_policy;
      (* XXX: Temporarily disabled *)
      (*"Topic.of_string",       `Quick, Topic_test.of_string;*)
      "Topic.to_string",       `Quick, Topic_test.to_string;
    ];
    "Stomp_command", [
      "CONNECTED",             `Quick, Stomp_command_test.connected;
      "MESSAGE",               `Quick, Stomp_command_test.message;
      "RECEIPT",               `Quick, Stomp_command_test.receipt;
      "ERROR",                 `Quick, Stomp_command_test.error;
      "CONNECT",               `Quick, Stomp_command_test.connect;
      "SEND",                  `Quick, Stomp_command_test.send;
      "SUBSCRIBE",             `Quick, Stomp_command_test.subscribe;
      "UNSUBSCRIBE",           `Quick, Stomp_command_test.unsubscribe;
      "ACK",                   `Quick, Stomp_command_test.ack;
      "NACK",                  `Quick, Stomp_command_test.nack;
      "BEGIN",                 `Quick, Stomp_command_test.begin_;
      "COMMIT",                `Quick, Stomp_command_test.commit;
      "ABORT",                 `Quick, Stomp_command_test.abort;
      "DISCONNECT",            `Quick, Stomp_command_test.disconnect;
    ];
    "Stomp_frame", [
      "Stomp_frame.create",    `Quick, Stomp_frame_test.create;
      "Stomp_frame.command",   `Quick, Stomp_frame_test.command;
      "Stomp_frame.headers",   `Quick, Stomp_frame_test.headers;
      "Stomp_frame.body",      `Quick, Stomp_frame_test.body;
      "Stomp_frame.size",      `Quick, Stomp_frame_test.size;
      "Stomp_frame.to_string", `Quick, Stomp_frame_test.to_string;
    ];
  ]
