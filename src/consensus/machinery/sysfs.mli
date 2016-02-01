(* This is free and unencumbered software released into the public domain. *)

module GPIO : sig
  module Chip : sig
    val construct : Scripting.Table.t -> Device.t
  end
  module Pin : sig
    val construct : Scripting.Table.t -> Device.t
  end
end

(*
val open_gpio_chip : int -> Abstract.GPIO.Chip.t

val open_gpio_pin : int -> Abstract.GPIO.Mode.t -> Abstract.GPIO.Pin.t
*)
