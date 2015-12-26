(* This is free and unencumbered software released into the public domain. *)

open Prelude
open Syntax

module Protocol = struct
  let port = 1984
end

module Client = struct
  type t = Lwt_unix.sockaddr

  let any =
    Unix.(ADDR_INET (Unix.inet_addr_any, 0))

  let compare (a : t) (b : t) =
    Pervasives.compare a b

  let to_string = function
    | Unix.ADDR_INET (addr, port) ->
      Printf.sprintf "%s:%d" (Unix.string_of_inet_addr addr) port
    | Unix.ADDR_UNIX _ -> assert false
end

module Server = struct
  type t = Lwt_unix.file_descr
end
