(* This is free and unencumbered software released into the public domain. *)

(** The list of supported device drivers. *)
val list : (string * (string -> Device.t)) list

(** The count of supported device drivers. *)
val count : int

(** Determines whether a given named device driver is supported. *)
val exists : string -> bool

(** Returns the instantiation function for a given named device driver. *)
val find : string -> (string -> Device.t)

(** Invokes the given function for every supported device driver. *)
val iter : (string -> (string -> Device.t) -> unit) -> unit
