(* This is free and unencumbered software released into the public domain. *)

(** Returns a list with information about supported device drivers. *)
val list : (string * (string -> Device.t)) list

(** Invokes the given function for every supported device driver. *)
val iter : (string -> (string -> Device.t) -> unit) -> unit
