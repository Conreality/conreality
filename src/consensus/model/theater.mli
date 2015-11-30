(* This is free and unencumbered software released into the public domain. *)

val reset : unit -> unit
val is_empty : unit -> bool
val label : unit -> string option
val location : unit -> Geometry.P3.t option
val register : Object.t -> unit
val unregister : Object.t -> unit
val iter : (Object.t -> unit) -> unit
