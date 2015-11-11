(* This is free and unencumbered software released into the public domain. *)

(* Vectors and points *)

type vector3     (** 3D vector. *)
type point3     (** 3D point. *)

module Vector3 : sig
  type t = vector3
  val create : float -> float -> float -> t
  val x : t -> float
  val y : t -> float
  val z : t -> float
  val zero : t
  val invert : t -> t
  val ( + ) : t -> t -> t
  val ( - ) : t -> t -> t
  val ( = ) : t -> t -> bool
  val ( * ) : t -> float -> t
  val opposite : t -> t -> bool
  val dotproduct : t -> t -> float
  val crossproduct : t -> t -> t
  val magnitude : t -> float
  val normalize : t -> t
end

module Vector : sig
  type t = vector3
end

module Point3 : sig
  type t = point3
end

module Point : sig
  type t = point3
end

(* Matrices *)

type matrix2	(* 2x2 matrix *)
type m2		(* type alias *)

module Matrix2: sig
  type t = matrix2
  val create : float -> float -> float -> float -> t
  val e00 : t -> float
  val e01 : t -> float
  val e10 : t -> float
  val e11 : t -> float
  val zero : t
  val id : t
  val invert : t -> t
  val ( + ) : t -> t -> t
  val ( - ) : t -> t -> t
  val ( = ) : t -> t -> bool
  val smul : t -> float -> t
  val transpose : t -> t
  val ( * ) : t -> t -> t
  val emul : t -> t -> t
  val ediv : t -> t -> t
  val det : t -> float
  val trace : t -> float
  val inverse : t -> t
end

module M2: sig
  type t = m2
end

