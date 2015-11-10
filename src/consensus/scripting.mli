(* This is free and unencumbered software released into the public domain. *)

module Context : sig
  type t
  val create : unit -> t
  val load_file : t -> string -> unit
end
