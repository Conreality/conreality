(* This is free and unencumbered software released into the public domain. *)

(* Points *)

type p2     (** 2D point *)

module P2 : sig
  type t = p2
  val create : float -> float -> t
  val x : t -> float
  val y : t -> float
  val el : t -> int -> float
  val zero : t
  val eq : t -> t -> bool
  val ( = ) : t -> t -> bool
  val mid : t -> t -> t
  val distance : t -> t -> float
  val print : Format.formatter -> t -> unit
end

type p3     (** 3D point *)
type p      (** type alias *)
module P3 : sig
  type t = p3
  val create : float -> float -> float -> t
  val x : t -> float
  val y : t -> float
  val z : t -> float
  val el : t -> int -> float
  val zero : t
  val eq : t -> t -> bool
  val ( = ) : t -> t -> bool
  val mid : t -> t -> t
  val distance : t -> t -> float
  val print : Format.formatter -> t -> unit
end

module P = P3

(* Vectors *)

type v2     (** 2D vector *)

module V2 : sig
  type t = v2
  val create : float -> float -> t
  val x : t -> float
  val y : t -> float
  val el : t -> int -> float
  val zero : t
  val unitx : t
  val unity : t
  val invert : t -> t
  val neg : t -> t
  val add : t -> t -> t
  val ( + ) : t -> t -> t
  val sub : t -> t -> t
  val ( - ) : t -> t -> t
  val eq : t -> t -> bool
  val ( = ) : t -> t -> bool
  val smul : t -> float -> t
  val ( * ) : t -> float -> t
  val opposite : t -> t -> bool
  val dotproduct : t -> t -> float
  val magnitude : t -> float
  val magnitude2 : t -> float
  val normalize : t -> t
  val print : Format.formatter -> t -> unit
end

type v3     (** 3D vector *)
type v      (** type alias *)

module V3 : sig
  type t = v3
  val create : float -> float -> float -> t
  val x : t -> float
  val y : t -> float
  val z : t -> float
  val el : t -> int -> float
  val zero : t
  val unitx : t
  val unity : t
  val unitz : t
  val invert : t -> t
  val neg : t -> t
  val add : t -> t -> t
  val ( + ) : t -> t -> t
  val sub : t -> t -> t
  val ( - ) : t -> t -> t
  val eq : t -> t -> bool
  val ( = ) : t -> t -> bool
  val smul : t -> float -> t
  val ( * ) : t -> float -> t
  val opposite : t -> t -> bool
  val dotproduct : t -> t -> float
  val crossproduct : t -> t -> t
  val magnitude : t -> float
  val magnitude2 : t -> float
  val normalize : t -> t
  val print : Format.formatter -> t -> unit
end

module V : sig type t = v3 end

(* Matrices *)

type m2         (* 2x2 matrix *)

module M2: sig
  type t = m2
  val create : float -> float -> float -> float -> t
  val e00 : t -> float
  val e01 : t -> float
  val e10 : t -> float
  val e11 : t -> float
  val el : int -> int -> t -> float
  val zero : t
  val id : t
  val neg : t -> t
  val add : t -> t-> t
  val ( + ) : t -> t -> t
  val sub : t -> t-> t
  val ( - ) : t -> t -> t
  val eq : t -> t-> bool
  val ( = ) : t -> t -> bool
  val smul : t -> float -> t
  val transpose : t -> t
  val mul : t -> t-> t
  val ( * ) : t -> t -> t
  val emul : t -> t -> t
  val ediv : t -> t -> t
  val det : t -> float
  val trace : t -> float
  val inverse : t -> t
end

