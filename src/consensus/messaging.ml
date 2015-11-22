(* This is free and unencumbered software released into the public domain. *)

open Prelude

module Topic = struct
  type t = { path: string list; message_type: string; qos_policy: int }

  let separator_string = "/"
  let separator_char = (Char.of_string separator_string)

  let create path =
    if (List.exists (fun part -> String.contains part separator_char) path) then begin
      raise (Invalid_argument "topic path component must not contain the separator character")
    end;
    {path = path; message_type = ""; qos_policy = 0}

  let path topic = topic.path
  let message_type topic = topic.message_type
  let qos_policy topic = topic.qos_policy

  let of_string path = create [path] (* TODO: String.split path separator_char *)
  let to_string topic = String.concat separator_string topic.path
end

(* See: https://stomp.github.io/stomp-specification-1.2.html#Server_Frames *)
(* See: https://stomp.github.io/stomp-specification-1.2.html#Client_Frames *)
module Stomp_command = struct
  type t =
    (* Server commands *)
    | CONNECTED
    | MESSAGE
    | RECEIPT
    | ERROR
    (* Client commands *)
    | CONNECT
    | SEND
    | SUBSCRIBE
    | UNSUBSCRIBE
    | ACK
    | NACK
    | BEGIN
    | COMMIT
    | ABORT
    | DISCONNECT

  let of_string = function
    (* Server commands *)
    | "CONNECTED" -> CONNECTED
    | "MESSAGE" -> MESSAGE
    | "RECEIPT" -> RECEIPT
    | "ERROR" -> ERROR
    (* Client commands *)
    | "CONNECT" -> CONNECT
    | "SEND" -> SEND
    | "SUBSCRIBE" -> SUBSCRIBE
    | "UNSUBSCRIBE" -> UNSUBSCRIBE
    | "ACK" -> ACK
    | "NACK" -> NACK
    | "BEGIN" -> BEGIN
    | "COMMIT" -> COMMIT
    | "ABORT" -> ABORT
    | "DISCONNECT" -> DISCONNECT
    | input -> raise (Invalid_argument input)

  let to_string = function
    (* Server commands *)
    | CONNECTED -> "CONNECTED"
    | MESSAGE -> "MESSAGE"
    | RECEIPT -> "RECEIPT"
    | ERROR -> "ERROR"
    (* Client commands *)
    | CONNECT -> "CONNECT"
    | SEND -> "SEND"
    | SUBSCRIBE -> "SUBSCRIBE"
    | UNSUBSCRIBE -> "UNSUBSCRIBE"
    | ACK -> "ACK"
    | NACK -> "NACK"
    | BEGIN -> "BEGIN"
    | COMMIT -> "COMMIT"
    | ABORT -> "ABORT"
    | DISCONNECT -> "DISCONNECT"

  let length command =
    (String.length (to_string command))
end

(* See: https://stomp.github.io/stomp-specification-1.2.html#STOMP_Frames *)
module Stomp_header = struct
  type t = { key: string; value: string }

  let create key value = { key; value }

  let key header = header.key
  let value header = header.value

  let of_string input = assert false (* TODO *)

  let to_string header =
    Printf.sprintf "%s:%s" header.key header.value

  let length command =
    (String.length command.key) + 1 + (String.length command.value)
end

(* See: https://stomp.github.io/stomp-specification-1.2.html#STOMP_Frames *)
module Stomp_frame = struct
  type t = { command: Stomp_command.t; headers: Stomp_header.t list; body: string }

  let create command headers body = { command; headers; body }

  let command frame = frame.command
  let headers frame = frame.headers
  let body frame = frame.body

  let size frame =
    (Stomp_command.length frame.command) + 1 +
    (List.fold_left (+) 0
      (List.map
        (fun header -> Stomp_header.length header + 1)
        frame.headers)) + 1 +
    (String.length frame.body) + 1

  let to_string frame =
    let buffer = Buffer.create (size frame) in
    Buffer.add_string buffer (Stomp_command.to_string frame.command);
    Buffer.add_char buffer '\n';
    List.iter
      (fun header ->
        Buffer.add_string buffer (Stomp_header.to_string header);
        Buffer.add_char buffer '\n')
      frame.headers;
    Buffer.add_char buffer '\n';
    Buffer.add_string buffer frame.body;
    Buffer.add_char buffer '\x00';
    Buffer.to_bytes buffer
end

(* See: https://stomp.github.io/stomp-specification-1.2.html *)
module Stomp_protocol = struct
  open Stomp_command

  (* See: https://stomp.github.io/stomp-specification-1.2.html#CONNECT_or_STOMP_Frame *)
  let make_connect_frame host login passcode =
    Stomp_frame.create CONNECT
      [Stomp_header.create "accept-version" "1.2";
       Stomp_header.create "host" host;
       Stomp_header.create "login" login;
       Stomp_header.create "passcode" passcode]
      ""

  (* See: https://stomp.github.io/stomp-specification-1.2.html#SEND *)
  let make_send_frame destination content_type body =
    Stomp_frame.create SEND
      [Stomp_header.create "destination" destination;
       Stomp_header.create "content-type" content_type;
       Stomp_header.create "content-length" (String.of_int (String.length body))]
      body

  (* See: https://stomp.github.io/stomp-specification-1.2.html#SUBSCRIBE *)
  let make_subscribe_frame id destination =
    Stomp_frame.create SUBSCRIBE
      [Stomp_header.create "id" id;
       Stomp_header.create "destination" destination;
       Stomp_header.create "ack" "auto"]
      ""

  (* See: https://stomp.github.io/stomp-specification-1.2.html#UNSUBSCRIBE *)
  let make_unsubscribe_frame id =
    Stomp_frame.create UNSUBSCRIBE
      [Stomp_header.create "id" id]
      ""

  (* See: https://stomp.github.io/stomp-specification-1.2.html#ACK *)
  let make_ack_frame id transaction =
    Stomp_frame.create ACK
      [Stomp_header.create "id" id;
       Stomp_header.create "transaction" transaction]
      ""

  (* See: https://stomp.github.io/stomp-specification-1.2.html#NACK *)
  let make_nack_frame id transaction =
    Stomp_frame.create NACK
      [Stomp_header.create "id" id;
       Stomp_header.create "transaction" transaction]
      ""

  (* See: https://stomp.github.io/stomp-specification-1.2.html#BEGIN *)
  let make_begin_frame transaction =
    Stomp_frame.create BEGIN
      [Stomp_header.create "transaction" transaction]
      ""

  (* See: https://stomp.github.io/stomp-specification-1.2.html#COMMIT *)
  let make_commit_frame transaction =
    Stomp_frame.create COMMIT
      [Stomp_header.create "transaction" transaction]
      ""

  (* See: https://stomp.github.io/stomp-specification-1.2.html#ABORT *)
  let make_abort_frame transaction =
    Stomp_frame.create ABORT
      [Stomp_header.create "transaction" transaction]
      ""

  (* See: https://stomp.github.io/stomp-specification-1.2.html#DISCONNECT *)
  let make_disconnect_frame receipt =
    Stomp_frame.create DISCONNECT
      [Stomp_header.create "receipt" receipt]
      ""
end
