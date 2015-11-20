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

  let of_string path = create [path] (* TODO: String.split path separator_char *)
  let to_string topic = String.concat separator_string topic.path

  let path topic = topic.path
  let message_type topic = topic.message_type
  let qos_policy topic = topic.qos_policy
end

(* See: https://stomp.github.io/stomp-specification-1.2.html#STOMP_Frames *)
module Stomp_frame = struct
  type t = { command: string; headers: string list; body: string }

  let create command headers body =
    {command = command; headers = headers; body = body}

  let to_string frame = "" (* TODO *)

  let command frame = frame.command
  let headers frame = frame.headers
  let body frame = frame.body
end
