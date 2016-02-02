(* This is free and unencumbered software released into the public domain. *)

open Prelude
open Scripting

module GPIO = struct
  module Mode = Abstract.GPIO.Mode

  module Chip = struct
    (* TODO *)

    let construct (config : Scripting.Table.t) : Device.t =
      failwith "Not implemented as yet" (* TODO *)
  end

  module Pin = struct
    let base_flags  = [Unix.O_CLOEXEC]
    let read_flags  = Unix.O_RDONLY :: base_flags
    let write_flags = Unix.O_WRONLY :: base_flags

    let get_path id op =
      let jail_path = "" in (* TODO: Unix.getenv "CONREAL_JAIL" *)
      match op with
        | "export" | "unexport" ->
          Printf.sprintf "%s/sys/class/gpio/%s" jail_path op
        | "direction" | "value" ->
          Printf.sprintf "%s/sys/class/gpio/gpio%d/%s" jail_path id op
        | _ -> assert false

    let write_bytes_to_file bytes filepath =
      let fd = Unix.openfile filepath write_flags 0 in
      Unix.write fd bytes 0 (Bytes.length bytes) |> ignore;
      Unix.close fd

    let control op id =
      let fd = Unix.openfile (get_path id op) write_flags 0 in
      let buffer = Bytes.of_string (String.of_int id) in
      Unix.write fd buffer 0 (Bytes.length buffer) |> ignore;
      Unix.close fd

    let set_exported id enabled =
      control (if enabled then "export" else "unexport") id

    let set_direction id mode =
      write_bytes_to_file
        (Bytes.cat (Mode.to_bytes mode) (Bytes.make 1 '\n'))
        (get_path id "direction")

    type state = { fd: Unix.file_descr; mode: Mode.t }

    class implementation (id : int) = object (self)
      inherit Abstract.GPIO.Pin.interface id as super

      val mutable state : state option = None

      method reset =
        match state with
          | None -> ()
          | Some _ -> self#close; set_exported id false

      method is_privileged = true

      method driver_name = "sysfs.gpio.pin"

      method device_name = Printf.sprintf "gpio/pin/%d" id

      method is_closed =
        match state with None -> true | Some _ -> false

      method init (mode : Mode.t) =
        match state with
          | Some { mode = mode' } when mode' = mode -> ()
          | _ ->
            self#reset;
            set_exported id true;
            set_direction id mode;
            let flags = (Mode.to_flags mode) @ base_flags in
            let fd = Unix.openfile (get_path id "value") flags 0 in
            state <- Some { fd; mode }

      method close =
        match state with
          | None -> ()
          | Some { fd } -> Unix.close fd; state <- None

      method mode =
        match state with
          | None -> assert false
          | Some { mode } -> mode

      method read =
        match state with
          | None -> assert false
          | Some { mode } when mode <> Mode.Input -> assert false
          | Some { fd } ->
            let _ = Unix.lseek fd 0 Unix.SEEK_SET in
            let buffer = Bytes.make 1 '0' in
            let rc = Unix.read fd buffer 0 (Bytes.length buffer) in
            rc = 1 && (Bytes.get buffer 0) = '1'

      method write (value : bool) =
        match state with
          | None -> assert false
          | Some { mode } when mode <> Mode.Output -> assert false
          | Some { fd } ->
            let _ = Unix.lseek fd 0 Unix.SEEK_SET in
            let buffer = Bytes.of_string (if value then "1\n" else "0\n") in
            Unix.write fd buffer 0 (Bytes.length buffer) |> ignore

      initializer Abstract.GPIO.Pin.register (self :> Abstract.GPIO.Pin.t)
    end

    type t = implementation

    let construct (config : Scripting.Table.t) : Device.t =
      match Table.lookup config (Value.of_string "gpio") with
      | Table gpio_config -> begin
          let pin = begin
            match Table.lookup_int gpio_config "pin" with
            | Some n -> n
            | None -> failwith "Missing configuration key 'gpio.pin'"
          end in
          let direction = begin
            match Table.lookup_string gpio_config "direction" with
            | Some "in"  -> Mode.Input
            | Some "out" -> Mode.Output
            | Some _-> failwith "Invalid configuration key 'gpio.direction'"
            | None  -> failwith "Missing configuration key 'gpio.direction'"
          end in
          let device = new implementation pin in
          device#init direction;
          (device :> Device.t)
        end
      | _ -> failwith "Missing configuration key 'gpio'"
  end
end

(*
let open_gpio_chip id : Abstract.GPIO.Chip.t =
  failwith "Not implemented as yet" (* TODO *)

let open_gpio_pin id mode : Abstract.GPIO.Pin.t =
  let pin = new GPIO.Pin.implementation id in
  pin#init mode;
  pin
*)
