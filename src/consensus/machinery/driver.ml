(* This is free and unencumbered software released into the public domain. *)

open Prelude

type t = { name: string; constructor: (string -> Device.t) }

let bcm2835_gpio_pin (id : string) : Device.t =
  failwith "Not implemented as yet" (* TODO *)

let bcm2836_gpio_pin (id : string) : Device.t =
  failwith "Not implemented as yet" (* TODO *)

let sysfs_gpio_chip (id : string) : Device.t =
  ((Sysfs.open_gpio_chip (Int.of_string id)) :> Device.t)

let sysfs_gpio_pin (id : string) : Device.t =
  ((Sysfs.open_gpio_pin (Int.of_string id) GPIO.Mode.Input) :> Device.t)

let list =
  [{ name = "bcm2835.gpio.pin"; constructor = bcm2835_gpio_pin };
   { name = "bcm2836.gpio.pin"; constructor = bcm2836_gpio_pin };
   { name = "sysfs.gpio.chip";  constructor = sysfs_gpio_chip  };
   { name = "sysfs.gpio.pin";   constructor = sysfs_gpio_pin   }]

let count = List.length list

let exists name =
  List.exists (fun driver -> driver.name = name) list

let find name =
  List.find (fun driver -> driver.name = name) list

let iter (f : (t -> unit)) = List.iter f list
