(* This is free and unencumbered software released into the public domain. *)

open Prelude

type t = { name: string; constructor: (string -> Device.t) }

let register name constructor = { name; constructor }

let list =
  [register "bcm2835.gpio.pin" BCM2835.GPIO.Pin.construct;
   register "bcm2836.gpio.pin" BCM2836.GPIO.Pin.construct;
   register "sysfs.gpio.chip"  Sysfs.GPIO.Chip.construct;
   register "sysfs.gpio.pin"   Sysfs.GPIO.Pin.construct;
   register "v4l2.camera"      V4L2.Camera.construct]

let count = List.length list

let exists name =
  List.exists (fun driver -> driver.name = name) list

let find name =
  List.find (fun driver -> driver.name = name) list

let iter (f : (t -> unit)) = List.iter f list
