(* This is free and unencumbered software released into the public domain. *)

(** Configuration. *)

module Devices : sig
  #include "config/devices.mli"
end

module Network : sig
  #include "config/network.mli"
end

type t = {
  devices: Devices.t;
  network: Network.t;
}

val create : unit -> t
val load_file : string -> t
