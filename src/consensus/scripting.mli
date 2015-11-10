(* This is free and unencumbered software released into the public domain. *)

exception Input_error of string
exception Parse_error of string
exception Runtime_error of string

module Context : sig
  type t
  val create : unit -> t
  val load_code : t -> string -> unit
  val load_file : t -> string -> unit
  val eval_code : t -> string -> unit
  val eval_file : t -> string -> unit
  val get_string : t -> string -> string
end
