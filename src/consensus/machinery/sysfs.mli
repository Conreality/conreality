(* This is free and unencumbered software released into the public domain. *)

val open_gpio_chip : int -> GPIO.Chip.t

val open_gpio_pin : int -> GPIO.Mode.t -> GPIO.Pin.t
