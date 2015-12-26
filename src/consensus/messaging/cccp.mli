(* This is free and unencumbered software released into the public domain. *)

module Protocol : sig
  val port : int
end

module Client : sig
  type t = Lwt_unix.sockaddr
  val any : t
  val compare : t -> t -> int
  val to_string : t -> string
end

module Server : sig
  type t
  val create : Networking.UDP.Socket.t -> t
  val socket : t -> Networking.UDP.Socket.t
end
