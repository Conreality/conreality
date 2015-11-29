(* This is free and unencumbered software released into the public domain. *)

(* See: http://linuxtv.org/downloads/v4l-dvb-apis/ *)
module Camera : sig
  val construct : string -> Device.t
end
