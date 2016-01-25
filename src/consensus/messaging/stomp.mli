(* This is free and unencumbered software released into the public domain. *)

#if OCAMLVERSION < 4020
type bytes = string
#endif

module Command : sig
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

module Header : sig
  type t
  val create : string -> string -> t
  val key : t -> string
  val value : t -> string
  val length : t -> int
  val of_string : string -> t
  val to_string : t -> string
end

module Frame : sig
  type t
  val create : Command.t -> Header.t list -> string -> t
  val command : t -> Command.t
  val headers : t -> Header.t list
  val body : t -> string
  val size : t -> int
  val to_bytes : t -> bytes
  val to_string : t -> string
end

module Protocol : sig
  val make_connect_frame : string -> string -> string -> Frame.t
  val make_send_frame : string -> string -> string -> Frame.t
  val make_subscribe_frame : string -> string -> Frame.t
  val make_unsubscribe_frame : string -> Frame.t
  val make_ack_frame : string -> string -> Frame.t
  val make_nack_frame : string -> string -> Frame.t
  val make_begin_frame : string -> Frame.t
  val make_commit_frame : string -> Frame.t
  val make_abort_frame : string -> Frame.t
  val make_disconnect_frame : string -> Frame.t
end
