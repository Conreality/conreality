(* This is free and unencumbered software released into the public domain. *)

module GPIO : sig
  module Pin : sig
    val construct : string -> Device.t
  end
end
