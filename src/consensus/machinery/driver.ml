(* This is free and unencumbered software released into the public domain. *)

open Prelude

let bcm2835_gpio_pin (config : string) : Device.t =
  failwith "Not implemented as yet"

let bcm2836_gpio_pin (config : string) : Device.t =
  failwith "Not implemented as yet"

let sysfs_gpio_chip (config : string) : Device.t =
  ((Sysfs.open_gpio_chip (Int.of_string config)) :> Device.t)

let sysfs_gpio_pin (config : string) : Device.t =
  ((Sysfs.open_gpio_pin (Int.of_string config) GPIO.Mode.Input) :> Device.t)

let list =
  [("bcm2835.gpio.pin", bcm2835_gpio_pin);
   ("bcm2836.gpio.pin", bcm2836_gpio_pin);
   ("sysfs.gpio.chip" , sysfs_gpio_chip);
   ("sysfs.gpio.pin",   sysfs_gpio_pin)]

let iter (f : (string -> (string -> Device.t) -> unit)) =
  List.iter (fun (k, v) -> f k v |> ignore) list
