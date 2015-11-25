(* This is free and unencumbered software released into the public domain. *)

open Prelude

module Chip = struct
  (* TODO *)
end

module Pin = struct
  let read_flags  = [Unix.O_RDONLY; Unix.O_CLOEXEC]
  let write_flags = [Unix.O_WRONLY; Unix.O_CLOEXEC]

  let get_path id op =
    let jail_path = "" in (* TODO: Unix.getenv "CONREAL_JAIL" *)
    match op with
      | "export" -> jail_path ^ "/sys/class/gpio/export"
      | "direction" | "value" ->
        Printf.sprintf "%s/sys/class/gpio/gpio%d/%s" jail_path id op
      | _ -> assert false

  class driver (id : int) = object (self)
    inherit GPIO.Pin.driver id as super

    method mode () =
      let fd = Unix.openfile (get_path id "direction") read_flags 0 in
      let buffer = Bytes.make 4 '\x00' in
      Unix.read fd buffer 0 (Bytes.length buffer) |> ignore;
      Unix.close fd;
      GPIO.Mode.of_bytes buffer

    method set_mode (mode : GPIO.Mode.t) =
      let fd = Unix.openfile (get_path id "direction") write_flags 0 in
      let buffer = (Bytes.cat (GPIO.Mode.to_bytes mode) (Bytes.make 1 '\n')) in
      Unix.write fd buffer 0 (Bytes.length buffer) |> ignore;
      Unix.close fd

    method read () =
      let fd = Unix.openfile (get_path id "value") read_flags 0 in
      let buffer = Bytes.make 1 '0' in
      let rc = Unix.read fd buffer 0 (Bytes.length buffer) in
      rc = 1 && (Bytes.get buffer 0) = '1'

    method write (value : bool) =
      let fd = Unix.openfile (get_path id "value") write_flags 0 in
      let buffer = Bytes.of_string (if value then "1\n" else "0\n") in
      Unix.write fd buffer 0 (Bytes.length buffer) |> ignore;
      Unix.close fd
  end

  type t = driver
end

let open_gpip_chip id = () (* TODO *)

let open_gpio_pin id : GPIO.Pin.t =
  new Pin.driver id
