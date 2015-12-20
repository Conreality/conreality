(* This is free and unencumbered software released into the public domain. *)

module Socket : sig
  type t = Lwt_unix.file_descr
  val bind : string -> int -> t
  val recvfrom : t -> Lwt_bytes.t -> (int * Unix.sockaddr) Lwt.t
end
