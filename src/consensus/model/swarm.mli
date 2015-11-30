(* This is free and unencumbered software released into the public domain. *)

class virtual interface : object
  (* Swarm interface: *)
  method network : Network.t
end

type t = interface
