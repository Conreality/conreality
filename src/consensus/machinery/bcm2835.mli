(* This is free and unencumbered software released into the public domain. *)

module GPIO : sig
  module Pin : sig
    val construct : Scripting.Table.t -> Device.t
  end
end
