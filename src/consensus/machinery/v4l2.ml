(* This is free and unencumbered software released into the public domain. *)

open Prelude

module Camera = struct
  type state = { fd: Unix.file_descr }

  class implementation (id : string) = object (self)
    inherit Abstract.Camera.interface as super

    val mutable state : state option = None

    method is_privileged = true

    method driver_name = "v4l2.camera"

    method device_name = Printf.sprintf "v4l2/camera/%s" id

    (* See: http://linuxtv.org/downloads/v4l-dvb-apis/func-open.html *)
    method init =
      match state with
        | Some _ -> ()
        | _ ->
          self#reset;
          let flags = [Unix.O_RDWR] in
          let fd = Unix.openfile id flags 0 in
          state <- Some { fd }

    (* See: http://linuxtv.org/downloads/v4l-dvb-apis/func-close.html *)
    method close =
      match state with
        | None -> ()
        | Some { fd } -> Unix.close fd; state <- None
  end

  type t = implementation

  let construct (id : string) : Device.t =
    let camera = new implementation id in
    (camera :> Device.t)
end

let open_camera id : Device.t =
  let camera = new Camera.implementation id in
  camera#init;
  (camera :> Device.t)
