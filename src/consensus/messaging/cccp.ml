(* This is free and unencumbered software released into the public domain. *)

open Prelude
open Syntax

module Protocol = struct
  let port = 1984
end

module Client = struct
  type t = Lwt_unix.file_descr
end

module Server = struct
  type t = Lwt_unix.file_descr
end
