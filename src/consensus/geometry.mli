(* This is free and unencumbered software released into the public domain. *)

type vector     (** 3D vector. *)
type point      (** 3D point. *)

module Vector : sig
  type t = vector
  val create : float -> float -> float -> t
  val x : vector -> float
  val y : vector -> float
  val z : vector -> float
  val zero : unit -> t
  val ( + ) : t -> t -> t
  val ( - ) : t -> t -> t
  val ( = ) : t -> t -> bool
  val ( * ) : t -> float -> t
  val opposite : vector -> vector -> bool
  val dotproduct : vector -> vector -> float
  val crossproduct : vector -> vector -> vector
  val invert : vector -> vector
  val magnitude : vector -> float
  val normalize : vector -> vector
end

module Point : sig
  type t = point
end
