(* This is free and unencumbered software released into the public domain. *)

type 'a t = { name: string; constructor: (Scripting.Table.t -> 'a Device.t) }

(** The list of supported device drivers. *)
val list : ([> `Camera of 'a Abstract.Camera.t] as 'a) t list

(** The count of supported device drivers. *)
val count : int

(** Determines whether a given named device driver is supported. *)
val exists : string -> bool

(** Returns the instantiation function for a given named device driver. *)
val find : string -> 'a t

(** Invokes the given function for every supported device driver. *)
val iter : ('a t -> unit) -> unit
