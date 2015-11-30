(* This is free and unencumbered software released into the public domain. *)

open Prelude
open Measures

module P3 = struct
  include Geometry.P3

  let is_zero p = (p = zero)
  let is_nonzero p = not (is_zero p)
end

module V3 = struct
  include Geometry.V3

  let is_zero v = (v = zero)
  let is_nonzero v = not (is_zero v)
end

module Q = struct
  include Geometry.Q

  let is_zero q = (q = zero)
  let is_nonzero q = not (is_zero q)
end

class virtual interface (id : int) = object (self)
  method id = id

  method label : string option = None

  method position =
    Some P3.zero (* TODO *)

  method orientation =
    Some Q.zero (* TODO *)

  method linear_velocity =
    Some V3.zero (* TODO *)

  method angular_velocity =
    Some Q.zero (* TODO *)

  method linear_acceleration =
    Some V3.zero (* TODO *)

  method mass =
    Some (Mass (0., kilogram)) (* TODO *)

  method shape : Object_shape.t option =
    None (* TODO *)

  method color : unit option =
    None (* TODO *)

  method inverse_mass =
    match self#mass with
      | None -> None
      | Some mass -> Some (Quantity.inverse mass)

  method is_located =
    match self#position with
      | None -> false (* unknown position *)
      | Some _ -> true

  method is_immovable =
    match self#mass with
      | None -> false (* unknown mass *)
      | Some mass -> Float.is_infinite (Quantity.length mass)

  method is_moving =
    match self#linear_velocity with
      | None -> false (* unknown velocity *)
      | Some velocity -> V3.is_nonzero velocity

  method is_rotating =
    match self#angular_velocity with
      | None -> false (* unknown velocity *)
      | Some velocity -> Q.is_nonzero velocity

  method is_accelerating =
    match self#linear_acceleration with
      | None -> false (* unknown acceleration *)
      | Some acceleration -> V3.is_nonzero acceleration

  method is_active =
    self#is_moving (* TODO? *)

  method is_inactive =
    not self#is_active

  method to_string : string =
    failwith "Not implemented as yet" (* TODO *)

  method intent_assessment =
    Intent_designation.Unknown

  method threat_assessment =
    Threat_level.Unknown
end

type t = interface
