(* This is free and unencumbered software released into the public domain. *)

type t = Lua_api_lib.state

(** Creates a new scripting context. *)
val create : unit -> t

val push_nil : t -> unit

val push_bool : t -> bool -> unit

val push_int : t -> int -> unit

val push_float : t -> float -> unit

val push_string : t -> string -> unit

val push_value : t -> Value.t -> unit

val get_bool : t -> bool

val get_int : t -> int

val get_float : t -> float

val get_string : t -> string

val get_value : t -> Value.t

val pop : t -> unit

val pop_bool : t -> bool

val pop_int : t -> int

val pop_float : t -> float

val pop_string : t -> string

val pop_value : t -> Value.t

(** Defines a global function in a scripting context. *)
val define : t -> string -> (t -> int) -> unit

val undefine : t -> string -> unit

val load_code : t -> string -> unit

val load_file : t -> string -> unit

val eval_code : t -> string -> unit

val eval_file : t -> string -> unit

val eval_as_value : t -> string -> Value.t

val get_field_as_string : t -> string -> string
