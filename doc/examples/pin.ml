#!/usr/bin/env ocaml
(* This is free and unencumbered software released into the public domain. *)

(* Note: this program requires root privileges; run it with `sudo`. *)

#use "topfind";;
#thread;;

#require "consensus";;
#require "consensus.machinery";;

open Consensus.Prelude;;
open Consensus.Machinery;;
open Printf;;

let pin_id =
  if (Array.length Sys.argv) > 1
  then Int.of_string Sys.argv.(1)
  else 18;; (* The default pin is GPIO 18. *)

printf "Opening GPIO pin %d...\n" pin_id;;
let pin = Sysfs.open_gpio_pin pin_id GPIO.Mode.Input;;

pin#reset;;

printf "Opening GPIO pin %d for input...\n" pin_id;;
pin#init GPIO.Mode.Input;;
pin#mode;;

printf "Reading GPIO pin %d value: " pin_id;;
let value = pin#read;;
printf "%s.\n" (if value then "1" else "0");;

printf "Opening GPIO pin %d for output...\n" pin_id;;
pin#init GPIO.Mode.Output;;
pin#mode;;

printf "Writing GPIO pin %d value: 1...\n" pin_id;;
pin#write true;;

printf "Writing GPIO pin %d value: 0...\n" pin_id;;
pin#write false;;
