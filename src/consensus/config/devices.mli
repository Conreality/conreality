(* This is free and unencumbered software released into the public domain. *)

type 'a t = {
  classes: (string, unit) Hashtbl.t;
  instances: (string, 'a Machinery.Device.t) Hashtbl.t;
}

val is_registered : 'a t -> string -> bool
val register : 'a t -> string -> Scripting.Table.t -> unit
val unregister : 'a t -> string -> unit
val find : 'a t -> string -> 'a Machinery.Device.t option
