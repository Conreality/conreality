(* This is free and unencumbered software released into the public domain. *)

class virtual interface : int -> object
  (** The unique object identifier. *)
  method id : int

  (** The human-readable label, if any, for the object. *)
  method label : string option

  (** The current observed position, if any, of this object. *)
  method position : Geometry.P3.t option

  (** The current observed orientation, if any, of this object. *)
  method orientation : Geometry.Q.t option

  (** The current estimated linear velocity, if any, of this object. *)
  method linear_velocity : Geometry.V3.t option

  (** The current estimated angular velocity, if any, of this object. *)
  method angular_velocity : Geometry.Q.t option

  (** The current estimated linear acceleration, if any, of this object. *)
  method linear_acceleration : Geometry.V3.t option

  (** The estimated mass, if any, of this object. *)
  method mass : Measures.Quantity.t option

  (** The approximated shape, if any, of this object. *)
  method shape : Object_shape.t option

  (** The approximated color, if any, of this object. *)
  method color : unit option

  (** Computes the inverse mass of this object.
      Immovable objects have zero inverse mass. *)
  method inverse_mass : Measures.Quantity.t option

  (** Determines whether this object has a nonzero position. *)
  method is_located : bool

  (** Determines whether this is an immovable physical object.
      Objects with infinite mass are immovable. *)
  method is_immovable : bool

  (** Determines whether this object has a nonzero linear velocity. *)
  method is_moving : bool

  (** Determines whether this object has a nonzero angular velocity. *)
  method is_rotating : bool

  (** Determines whether this object has a nonzero linear acceleration. *)
  method is_accelerating : bool

  (** Determines whether this object is currently active. *)
  method is_active : bool

  (** Determines whether this object is currently inactive. *)
  method is_inactive : bool

  (** Returns a human-readable string representation of this object. *)
  method to_string : string

  (** TODO *)
  method intent_assessment : Intent_designation.t

  (** TODO *)
  method threat_assessment : Threat_level.t
end

type t = interface
