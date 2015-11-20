(* This is free and unencumbered software released into the public domain. *)

module Topic : sig
  type t
  val separator_string : string
  val separator_char : char
  val create : string list -> t
  val of_string : string -> t
  val to_string : t -> string
  val path : t -> string list
  val message_type : t -> string
  val qos_policy : t -> int
end

module Stomp_frame : sig
  type t
  val create : string -> string list -> string -> t
  val to_string : t -> string
  val command : t -> string
  val headers : t -> string list
  val body : t -> string
end
