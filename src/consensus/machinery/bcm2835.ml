(* This is free and unencumbered software released into the public domain. *)

open Prelude

module GPIO = struct
  module Pin = struct
    class ['a] implementation = object (self)
      inherit ['a] Device.interface as super

      method cast = `GPIO_Pin self

      method is_privileged = true

      method driver_name = "bcm2835"

      method device_name = "bcm2835"
    end

    type 'a t = 'a implementation

    let construct (config : Scripting.Table.t) : 'a Device.t =
      failwith "Not implemented as yet" (* TODO *)
  end
end
