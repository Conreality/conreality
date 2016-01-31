(* This is free and unencumbered software released into the public domain. *)

module GPIO : sig
  module Chip : sig
    val construct : Scripting.Table.t -> 'a Device.t
  end
  module Pin : sig
    val construct : Scripting.Table.t -> ([> `GPIO_Pin of 'a Abstract.GPIO.Pin.interface] as 'a) Device.t
  end
end

(*
val open_gpio_chip : int -> 'a Abstract.GPIO.Chip.t

val open_gpio_pin : int -> Abstract.GPIO.Mode.t -> 'a Abstract.GPIO.Pin.t
*)
