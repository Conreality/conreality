(* This is free and unencumbered software released into the public domain. *)

open Prelude

module Mode = struct
  type t = Input | Output

  let of_string = function
    | "in" -> Input
    | "out" -> Output
    | _ -> assert false

  let to_string = function
    | Input -> "in"
    | Output -> "out"

  let of_bytes bytes =
    Bytes.map (fun byte -> if byte = '\x00' then ' ' else byte) bytes |>
    Bytes.trim |> Bytes.to_string |> of_string

  let to_bytes mode =
    Bytes.of_string (to_string mode)
end

module Chip = struct
  class virtual driver (id : int) = object (self)
    inherit Device.driver as super

    method driver_name = "gpio.chip"

    method device_name = Printf.sprintf "gpio/chip%d" id

    method id = id

    (* TODO *)
  end

  type t = driver
end

module Pin = struct
  class virtual driver (id : int) = object (self)
    inherit Device.driver as super

    method driver_name = "gpio.pin"

    method device_name = Printf.sprintf "gpio/pin%d" id

    method id = id

    method virtual mode : Mode.t

    method virtual set_mode : Mode.t -> unit

    method virtual read : bool

    method virtual write : bool -> unit
  end

  type t = driver
end
