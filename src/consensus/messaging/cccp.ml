(* This is free and unencumbered software released into the public domain. *)

open Prelude

module Protocol = struct
  let port = 1984
end

module Command = struct
  type t =
    (* Device Control *)
    | Enable of string
    | Disable of string
    | Toggle of string

  let to_string = function
    (* Device Control *)
    | Enable id -> Printf.sprintf "enable(%s)" id
    | Disable id -> Printf.sprintf "disable(%s)" id
    | Toggle id -> Printf.sprintf "toggle(%s)" id

  let length command =
    (String.length (to_string command))
end

module Client = struct
  type t = Lwt_unix.file_descr
end

module Server = struct
  type t = Lwt_unix.file_descr
end
