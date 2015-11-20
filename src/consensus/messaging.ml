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
end

(* See: https://stomp.github.io/stomp-specification-1.2.html#STOMP_Frames *)
module Stomp_frame = struct
  type t = { command: string; headers: string list; body: string }

  let create command headers body =
    {command = command; headers = headers; body = body}

  let command frame = frame.command
  let headers frame = frame.headers
  let body frame = frame.body

  let size frame =
    (String.length frame.command) + 1 +
    (List.fold_left (+) 0
      (List.map
        (fun header -> String.length header + 1)
        frame.headers)) + 1 +
    (String.length frame.body) + 1

  let to_string frame =
    let buffer = Buffer.create (size frame) in
    Buffer.add_string buffer frame.command;
    Buffer.add_char buffer '\n';
    List.iter
      (fun header ->
        Buffer.add_string buffer header;
        Buffer.add_char buffer '\n')
      frame.headers;
    Buffer.add_char buffer '\n';
    Buffer.add_string buffer frame.body;
    Buffer.add_char buffer '\x00';
    Buffer.to_bytes buffer
end
