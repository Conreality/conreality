(* This is free and unencumbered software released into the public domain. *)

class virtual interface : int -> object
  inherit Object.interface
  (* Object interface: *)
  method id : int
  method label : string option
  method position : Geometry.P3.t option
  method orientation : Geometry.Q.t option
  method linear_velocity : Geometry.V3.t option
  method angular_velocity : Geometry.Q.t option
  method linear_acceleration : Geometry.V3.t option
  method mass : Measures.Quantity.t option
  method shape : Object_shape.t option
  method color : unit option
  method inverse_mass : Measures.Quantity.t option
  method is_located : bool
  method is_immovable : bool
  method is_moving : bool
  method is_rotating : bool
  method is_accelerating : bool
  method is_active : bool
  method is_inactive : bool
  method to_string : string
  method intent_assessment : Intent_designation.t
  method threat_assessment : Threat_level.t
  (* Target interface: *)
end

type t = interface
