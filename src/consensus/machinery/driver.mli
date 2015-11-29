(* This is free and unencumbered software released into the public domain. *)

type t = string * (string -> Device.t)

(** The list of supported device drivers. *)
val list : t list

(** The count of supported device drivers. *)
val count : int

(** Determines whether a given named device driver is supported. *)
val exists : string -> bool

(** Returns the instantiation function for a given named device driver. *)
val find : string -> t

(** Invokes the given function for every supported device driver. *)
val iter : (t -> unit) -> unit
