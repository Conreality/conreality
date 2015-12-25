(* This is free and unencumbered software released into the public domain. *)

type t = (Value.t, Value.t) Hashtbl.t

val create : int -> t

val size : t -> int

val clear : t -> unit

val reset : t -> unit

val remove : t -> Value.t -> unit

val insert : t -> Value.t -> Value.t -> unit

val lookup : t -> Value.t -> Value.t

val iter : t -> (Value.t -> Value.t -> unit) -> unit
