(* This is free and unencumbered software released into the public domain. *)

open Prelude

module GPIO = struct
  module Mode = struct
    type t = Input | Output

    let of_string = function
      | "in"  -> Input
      | "out" -> Output
      | _ -> assert false

    let to_string = function
      | Input  -> "in"
      | Output -> "out"

    let of_bytes bytes =
      Bytes.map (fun byte -> if byte = '\x00' then ' ' else byte) bytes |>
      Bytes.trim |> Bytes.to_string |> of_string

    let to_bytes mode =
      Bytes.of_string (to_string mode)

    let to_flags = function
      | Input  -> [Unix.O_RDONLY]
      | Output -> [Unix.O_WRONLY]
  end

  module Chip = struct
    class virtual interface (id : int) = object (self)
      inherit Device.interface as super

      method driver_name = "gpio.chip"

      method device_name = Printf.sprintf "gpio/chip/%d" id

      method id = id

      (* TODO *)
    end

    type t = interface
  end

  module Pin = struct
    class virtual interface (id : int) = object (self)
      inherit Device.interface as super

      method driver_name = "gpio.pin"

      method device_name = Printf.sprintf "gpio/pin/%d" id

      method id = id

      method is_open = not self#is_closed

      method virtual is_closed : bool

      method virtual init : Mode.t -> unit

      method virtual close : unit

      method virtual mode : Mode.t

      method virtual read : bool

      method virtual write : bool -> unit
    end

    type t = interface
  end
end
