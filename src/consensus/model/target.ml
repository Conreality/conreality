(* This is free and unencumbered software released into the public domain. *)

open Prelude

class virtual interface (id : int) = object (self)
  inherit Object.interface id as super

  method intent_assessment = Intent_designation.Hostile

  method threat_assessment = Threat_level.Unknown

  (* TODO *)
end

type t = interface
