(* This is free and unencumbered software released into the public domain. *)

module Protocol : sig
  val port : int
end

module Client : sig
  type t
end

module Server : sig
  type t
end
