(* This is free and unencumbered software released into the public domain. *)

(** Configuration. *)

module Devices : sig
  type t
end

module Network : sig
  type t
end

type t

val load_file : string -> t
