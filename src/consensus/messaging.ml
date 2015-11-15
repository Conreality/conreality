(* This is free and unencumbered software released into the public domain. *)

open Prelude

module Topic = struct
  type t = { path: string list; message_type: string; qos_policy: int }

  let create path =
    {path = path; message_type = ""; qos_policy = 0}

  let path topic = topic.path
  let message_type topic = topic.message_type
  let qos_policy topic = topic.qos_policy

  let to_string topic = String.concat "/" topic.path
end
