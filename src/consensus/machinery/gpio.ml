(* This is free and unencumbered software released into the public domain. *)

module Mode = struct
  type t = Input | Output

  let of_string = function
    | "in" -> Input
    | "out" -> Output
    | _ -> assert false

  let to_string = function
    | Input -> "in"
    | Output -> "out"
end

module Pin = struct
  class pin (init : int) = object
    val id : int = init

    method id () = id

    method mode () = Mode.Output (* TODO *)

    method set_mode (mode : Mode.t) = () (* TODO *)

    method read () = false (* TODO *)

    method write (value : bool) = () (* TODO *)
  end

  type t = pin

  let make id = new pin id
end
