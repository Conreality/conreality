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

  let check command string =
    Alcotest.(check string) "string"
      string (Stomp_command.to_string command);
    Alcotest.(check string) "string"
      string (Stomp_command.to_string (Stomp_command.of_string string));
    Alcotest.(check int) "int"
      (String.length string) (Stomp_command.length command)

  let connected () =
    check CONNECTED "CONNECTED"

  let message () =
    check MESSAGE "MESSAGE"

  let receipt () =
    check RECEIPT "RECEIPT"

  let error () =
    check ERROR "ERROR"

  let connect () =
    check CONNECT "CONNECT"

  let send () =
    check SEND "SEND"

  let subscribe () =
    check SUBSCRIBE "SUBSCRIBE"

  let unsubscribe () =
    check UNSUBSCRIBE "UNSUBSCRIBE"

  let ack () =
    check ACK "ACK"

  let nack () =
    check NACK "NACK"

  let begin_ () =
    check BEGIN "BEGIN"

  let commit () =
    check COMMIT "COMMIT"

  let abort () =
    check ABORT "ABORT"

  let disconnect () =
    check DISCONNECT "DISCONNECT"
end

(* Messaging.Stomp_header *)

module Stomp_header_test = struct
  open Stomp_header

  let kv1_header =
    Stomp_header.create "key1" "val1"

  let kv2_header =
    Stomp_header.create "key2" "val2"

  let create () = todo ()

  let key () =
    Alcotest.(check string) "string"
      "key1" (Stomp_header.key kv1_header)

  let value () =
    Alcotest.(check string) "string"
      "val1" (Stomp_header.value kv1_header)

  let of_string () = todo ()

  let to_string () =
    Alcotest.(check string) "string"
      "key1:val1"
      (Stomp_header.to_string kv1_header)

  let length () =
    Alcotest.(check int) "int"
      (String.length (Stomp_header.to_string kv1_header))
      (Stomp_header.length kv1_header)
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
      "Topic.create",           `Quick, Topic_test.create;
      "Topic.path",             `Quick, Topic_test.path;
      "Topic.message_type",     `Quick, Topic_test.message_type;
      "Topic.qos_policy",       `Quick, Topic_test.qos_policy;
      (* XXX: Temporarily disabled *)
      (*"Topic.of_string",        `Quick, Topic_test.of_string;*)
      "Topic.to_string",        `Quick, Topic_test.to_string;
    ];
    "Stomp_command", [
      "CONNECTED",              `Quick, Stomp_command_test.connected;
      "MESSAGE",                `Quick, Stomp_command_test.message;
      "RECEIPT",                `Quick, Stomp_command_test.receipt;
      "ERROR",                  `Quick, Stomp_command_test.error;
      "CONNECT",                `Quick, Stomp_command_test.connect;
      "SEND",                   `Quick, Stomp_command_test.send;
      "SUBSCRIBE",              `Quick, Stomp_command_test.subscribe;
      "UNSUBSCRIBE",            `Quick, Stomp_command_test.unsubscribe;
      "ACK",                    `Quick, Stomp_command_test.ack;
      "NACK",                   `Quick, Stomp_command_test.nack;
      "BEGIN",                  `Quick, Stomp_command_test.begin_;
      "COMMIT",                 `Quick, Stomp_command_test.commit;
      "ABORT",                  `Quick, Stomp_command_test.abort;
      "DISCONNECT",             `Quick, Stomp_command_test.disconnect;
    ];
    "Stomp_header", [
      "Stomp_header.create",    `Quick, Stomp_header_test.create;
      "Stomp_header.key",       `Quick, Stomp_header_test.key;
      "Stomp_header.value",     `Quick, Stomp_header_test.value;
      "Stomp_header.of_string", `Quick, Stomp_header_test.of_string;
      "Stomp_header.to_string", `Quick, Stomp_header_test.to_string;
      "Stomp_header.length",    `Quick, Stomp_header_test.length;
    ];
    "Stomp_frame", [
      "Stomp_frame.create",     `Quick, Stomp_frame_test.create;
      "Stomp_frame.command",    `Quick, Stomp_frame_test.command;
      "Stomp_frame.headers",    `Quick, Stomp_frame_test.headers;
      "Stomp_frame.body",       `Quick, Stomp_frame_test.body;
      "Stomp_frame.size",       `Quick, Stomp_frame_test.size;
      "Stomp_frame.to_string",  `Quick, Stomp_frame_test.to_string;
    ];
  ]
