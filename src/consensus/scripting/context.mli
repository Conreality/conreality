(* This is free and unencumbered software released into the public domain. *)

type t = Lua_api_lib.state

(** Creates a new scripting context. *)
val create : unit -> t

(** Defines a global function in a scripting context. *)
val define : t -> string -> (t -> int) -> unit

val load_code : t -> string -> unit

val load_file : t -> string -> unit

val eval_code : t -> string -> unit

val eval_file : t -> string -> unit

val push_value : t -> Value.t -> unit

val get_value : t -> Value.t

val pop_value : t -> Value.t

val pop_string : t -> string

val get_field_as_string : t -> string -> string

val get_string : t -> string -> string
