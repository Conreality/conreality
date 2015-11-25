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

module Pin = struct
  let sysfs_path id op =
    let jail_path = "" in (* TODO: Unix.getenv "CONREAL_JAIL" *)
    match op with
      | "export" -> jail_path ^ "/sys/class/gpio/export"
      | "direction" | "value" ->
        Printf.sprintf "%s/sys/class/gpio/gpio%d/%s" jail_path id op
      | _ -> assert false

  let read_flags = [Unix.O_RDONLY; Unix.O_CLOEXEC]

  let write_flags = [Unix.O_WRONLY; Unix.O_CLOEXEC]

  class pin (init : int) = object
    val id : int = init

    method id () = id

    method mode () =
      let fd = Unix.openfile (sysfs_path id "direction") read_flags 0 in
      let buffer = Bytes.make 4 '\x00' in
      Unix.read fd buffer 0 (Bytes.length buffer) |> ignore;
      Unix.close fd;
      Mode.of_bytes buffer

    method set_mode (mode : Mode.t) =
      let fd = Unix.openfile (sysfs_path id "direction") write_flags 0 in
      let buffer = (Bytes.cat (Mode.to_bytes mode) (Bytes.make 1 '\n')) in
      Unix.write fd buffer 0 (Bytes.length buffer) |> ignore;
      Unix.close fd

    method read () =
      let fd = Unix.openfile (sysfs_path id "value") read_flags 0 in
      let buffer = Bytes.make 1 '0' in
      let rc = Unix.read fd buffer 0 (Bytes.length buffer) in
      rc = 1 && (Bytes.get buffer 0) = '1'

    method write (value : bool) =
      let fd = Unix.openfile (sysfs_path id "value") write_flags 0 in
      let buffer = Bytes.of_string (if value then "1\n" else "0\n") in
      Unix.write fd buffer 0 (Bytes.length buffer) |> ignore;
      Unix.close fd
  end

  type t = pin

  let make id = new pin id
end
