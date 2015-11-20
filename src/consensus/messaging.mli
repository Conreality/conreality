(* This is free and unencumbered software released into the public domain. *)

module Topic : sig
  type t
  val separator_string : string
  val separator_char : char
  val create : string list -> t
  val path : t -> string list
  val message_type : t -> string
  val qos_policy : t -> int
  val of_string : string -> t
  val to_string : t -> string
end

module Stomp_command : sig
  type t =
    | CONNECTED
    | MESSAGE
    | RECEIPT
    | ERROR
    | CONNECT
    | SEND
    | SUBSCRIBE
    | UNSUBSCRIBE
    | ACK
    | NACK
    | BEGIN
    | COMMIT
    | ABORT
    | DISCONNECT
  val of_string : string -> t
  val to_string : t -> string
  val length : t -> int
end

module Stomp_frame : sig
  type t
  val create : Stomp_command.t -> string list -> string -> t
  val command : t -> Stomp_command.t
  val headers : t -> string list
  val body : t -> string
  val to_string : t -> string
  val size : t -> int
end
