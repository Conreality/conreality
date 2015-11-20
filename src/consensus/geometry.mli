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
  val add : t -> t -> t
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
  val print : Format.formatter -> t -> unit
end

type m3         (* 3x3 matrix *)

module M3: sig
  type t = m3
  val create : float -> float -> float -> float -> float -> float -> float -> float -> float -> t
  val e00 : t -> float
  val e01 : t -> float
  val e02 : t -> float
  val e10 : t -> float
  val e11 : t -> float
  val e12 : t -> float
  val e20 : t -> float
  val e21 : t -> float
  val e22 : t -> float
  val el : int -> int -> t -> float
  val zero : t
  val id : t
  val neg : t -> t
  val add : t -> t -> t
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
  val print : Format.formatter -> t -> unit
end

type q          (* quaternion *)

module Q: sig
  type t = q
  val create : float -> float -> float -> float -> t
  val r : t -> float
  val a : t -> float
  val b : t -> float
  val c : t -> float
  val zero : t
  val real : t -> float
  val imag : t -> (float * float * float)
  val of_scalar : float -> t
  val to_list : t -> float list
  val of_list : float list -> t
  val add : t -> t -> t
  val sub : t -> t -> t
  val mul : t -> t -> t
  val ( + ) : t -> t -> t
  val ( - ) : t -> t -> t
  val ( * ) : t -> t -> t
  val eq : t -> t -> bool
  val ( = ) : t -> t -> bool
  val addr : t -> float -> t
  val subr : t -> float -> t
  val mulr : t -> float -> t
  val divr : t -> float -> t
  val smul : t -> float -> t
  val sdiv : t -> float -> t
  val norm2 : t -> float
  val norm : t -> float
  val conj : t -> t
  val neg : t -> t
  val inv : t -> t
  val unit : t -> t
  val dot : t -> t -> float
  val cos_theta : t -> t -> float
  val theta : t -> t -> float
  val slerp : t -> t -> float -> t
  val distance : t -> t -> float
    (*
  val nlerp : t -> t
  val squad : t -> t
  val of_euler : M3.t -> t
       *)
(*  val cross : t -> t -> t*)
end

