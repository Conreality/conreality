(* This is free and unencumbered software released into the public domain. *)

open Prelude
open Scripting

module Camera = struct
  type state = { fd: Unix.file_descr }

  class implementation (config : Table.t) = object (self)
    inherit Abstract.Camera.interface as super

    val mutable state : state option = None

    method is_privileged = true

    method driver_name = "v4l2.camera"

    method device_name = Printf.sprintf "v4l2/camera/%s" "" (* FIXME *)

    (* See: http://linuxtv.org/downloads/v4l-dvb-apis/func-open.html *)
    method init =
      match state with
        | Some _ -> () (* already initialized *)
        | _ ->
          self#reset;
          let id = Value.to_string (Table.lookup config (Value.of_string "id")) in
          let flags = [Unix.O_RDWR] in
          let fd = Unix.openfile id flags 0 in
          state <- Some { fd }

    (* See: http://linuxtv.org/downloads/v4l-dvb-apis/func-close.html *)
    method close =
      match state with
        | None -> ()
        | Some { fd } -> Unix.close fd; state <- None

    method read_frame =
      Bytes.of_string "" (* TODO *)

    initializer Abstract.Camera.register (self :> Abstract.Camera.t)
  end

  type t = implementation

  let construct (config : Scripting.Table.t) : Device.t =
    let camera = new implementation config in
    (camera :> Device.t)
end

(*
let open_camera id : Device.t =
  let camera = new Camera.implementation id in
  camera#init;
  (camera :> Device.t)
*)
