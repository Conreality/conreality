(* This is free and unencumbered software released into the public domain. *)

open Prelude

class virtual interface (id : int) = object (self)
  inherit Object.interface id as super

  method intent_assessment = Intent_designation.Friendly

  method threat_assessment = Threat_level.None

  method swarm : Swarm.t option =
    failwith "Not implemented as yet" (* TODO *)

  method ip_address : string option = (* TODO: use IPv4/IPv6 address type *)
    failwith "Not implemented as yet" (* TODO *)

  method ping : float option =
    failwith "Not implemented as yet" (* TODO *)

  method locate : Geometry.P3.t  =
    failwith "Not implemented as yet" (* TODO *)

  method synchronize : unit =
    failwith "Not implemented as yet" (* TODO *)
end

type t = interface
