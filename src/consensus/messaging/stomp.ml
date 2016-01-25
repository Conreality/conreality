(* This is free and unencumbered software released into the public domain. *)

#if OCAMLVERSION < 4020
type bytes = string
#endif

open Prelude

(* See: https://stomp.github.io/stomp-specification-1.2.html#Server_Frames *)
(* See: https://stomp.github.io/stomp-specification-1.2.html#Client_Frames *)
module Command = struct
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
module Header = struct
  type t = { key: string; value: string }

  let create key value = { key; value }

  let key header = header.key
  let value header = header.value

  let length command =
    (String.length command.key) + 1 + (String.length command.value)

  let of_string input = assert false (* TODO *)

  let to_string header =
    Printf.sprintf "%s:%s" header.key header.value
end

(* See: https://stomp.github.io/stomp-specification-1.2.html#STOMP_Frames *)
module Frame = struct
  type t = { command: Command.t; headers: Header.t list; body: string }

  let create command headers body = { command; headers; body }

  let command frame = frame.command
  let headers frame = frame.headers
  let body frame = frame.body

  let size frame =
    (Command.length frame.command) + 1 +
    (List.fold_left (+) 0
      (List.map
        (fun header -> Header.length header + 1)
        frame.headers)) + 1 +
    (String.length frame.body) + 1

  let to_bytes frame =
    let buffer = Buffer.create (size frame) in
    Buffer.add_string buffer (Command.to_string frame.command);
    Buffer.add_char buffer '\n';
    List.iter
      (fun header ->
        Buffer.add_string buffer (Header.to_string header);
        Buffer.add_char buffer '\n')
      frame.headers;
    Buffer.add_char buffer '\n';
    Buffer.add_string buffer frame.body;
    Buffer.add_char buffer '\x00';
#if OCAMLVERSION < 4020
    Buffer.contents buffer
#else
    Buffer.to_bytes buffer
#endif

  let to_string frame =
    Bytes.to_string (to_bytes frame)
end

(* See: https://stomp.github.io/stomp-specification-1.2.html *)
module Protocol = struct
  open Command

  (* See: https://stomp.github.io/stomp-specification-1.2.html#CONNECT_or_STOMP_Frame *)
  let make_connect_frame host login passcode =
    Frame.create CONNECT
      [Header.create "accept-version" "1.2";
       Header.create "host" host;
       Header.create "login" login;
       Header.create "passcode" passcode]
      ""

  (* See: https://stomp.github.io/stomp-specification-1.2.html#SEND *)
  let make_send_frame destination content_type body =
    Frame.create SEND
      [Header.create "destination" destination;
       Header.create "content-type" content_type;
       Header.create "content-length" (String.of_int (String.length body))]
      body

  (* See: https://stomp.github.io/stomp-specification-1.2.html#SUBSCRIBE *)
  let make_subscribe_frame id destination =
    Frame.create SUBSCRIBE
      [Header.create "id" id;
       Header.create "destination" destination;
       Header.create "ack" "auto"]
      ""

  (* See: https://stomp.github.io/stomp-specification-1.2.html#UNSUBSCRIBE *)
  let make_unsubscribe_frame id =
    Frame.create UNSUBSCRIBE
      [Header.create "id" id]
      ""

  (* See: https://stomp.github.io/stomp-specification-1.2.html#ACK *)
  let make_ack_frame id transaction =
    Frame.create ACK
      [Header.create "id" id;
       Header.create "transaction" transaction]
      ""

  (* See: https://stomp.github.io/stomp-specification-1.2.html#NACK *)
  let make_nack_frame id transaction =
    Frame.create NACK
      [Header.create "id" id;
       Header.create "transaction" transaction]
      ""

  (* See: https://stomp.github.io/stomp-specification-1.2.html#BEGIN *)
  let make_begin_frame transaction =
    Frame.create BEGIN
      [Header.create "transaction" transaction]
      ""

  (* See: https://stomp.github.io/stomp-specification-1.2.html#COMMIT *)
  let make_commit_frame transaction =
    Frame.create COMMIT
      [Header.create "transaction" transaction]
      ""

  (* See: https://stomp.github.io/stomp-specification-1.2.html#ABORT *)
  let make_abort_frame transaction =
    Frame.create ABORT
      [Header.create "transaction" transaction]
      ""

  (* See: https://stomp.github.io/stomp-specification-1.2.html#DISCONNECT *)
  let make_disconnect_frame receipt =
    Frame.create DISCONNECT
      [Header.create "receipt" receipt]
      ""
end
