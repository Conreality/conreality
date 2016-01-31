(* This is free and unencumbered software released into the public domain. *)

type t = {
  classes: (string, unit) Hashtbl.t;
  instances: (string, Machinery.Device.t) Hashtbl.t;
}

val is_registered : t -> string -> bool
val register : t -> string -> Scripting.Table.t -> unit
val unregister : t -> string -> unit
val find : t -> string -> Machinery.Device.t option
