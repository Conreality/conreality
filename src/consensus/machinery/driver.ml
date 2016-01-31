(* This is free and unencumbered software released into the public domain. *)

open Prelude
open Scripting

type 'a t = { name: string; constructor: (Table.t -> 'a Device.t) }

let register name constructor = { name; constructor }

let list =
  ([
(*
   register "bcm2835.gpio.pin" (BCM2835.GPIO.Pin.construct :> (Table.t -> 'a Device.t));
   register "bcm2836.gpio.pin" (BCM2836.GPIO.Pin.construct :> (Table.t -> 'a Device.t));
   register "sysfs.gpio.chip"  (Sysfs.GPIO.Chip.construct :> (Table.t -> 'a Device.t));
   register "sysfs.gpio.pin"   (Sysfs.GPIO.Pin.construct :> (Table.t -> 'a Device.t));
*)
   register "v4l2.camera"      (V4L2.Camera.construct : (Table.t -> 'a Device.t))
])

let count = List.length list

let exists name =
  List.exists (fun driver -> driver.name = name) list

let find name =
  List.find (fun driver -> driver.name = name) list

let iter (f : ('a t -> unit)) = List.iter f list
