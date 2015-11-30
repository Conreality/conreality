(* This is free and unencumbered software released into the public domain. *)

(* Dimensions of measurement *)
module Dimension : sig
  type t =
    | Length
    | Mass
    | Time
    | Current
    | Temperature
end

(* Scales of measurement *)
module Scale : sig
  type t = int
  val symbol_and_label : t -> string * string
  val symbol : t -> string
  val label : t -> string
end

(* Units of measurement *)
module Unit : sig
  type t
  val dimension : t -> Dimension.t
  val symbol : t -> string
  val scale : t -> Scale.t
  val to_string : t -> string
end

(* Length units *)
val terameter   : Unit.t
val gigameter   : Unit.t
val megameter   : Unit.t
val kilometer   : Unit.t
val hectometer  : Unit.t
val decameter   : Unit.t
val meter       : Unit.t
val decimeter   : Unit.t
val centimeter  : Unit.t
val millimeter  : Unit.t
val micrometer  : Unit.t
val nanometer   : Unit.t
val picometer   : Unit.t

(* Mass units *)
val teragram    : Unit.t
val gigagram    : Unit.t
val megagram    : Unit.t
val kilogram    : Unit.t
val hectogram   : Unit.t
val decagram    : Unit.t
val gram        : Unit.t
val decigram    : Unit.t
val centigram   : Unit.t
val milligram   : Unit.t
val microgram   : Unit.t
val nanogram    : Unit.t
val picogram    : Unit.t

(* Time units *)
val terasecond  : Unit.t
val gigasecond  : Unit.t
val megasecond  : Unit.t
val kilosecond  : Unit.t
val hectosecond : Unit.t
val decasecond  : Unit.t
val second      : Unit.t
val decisecond  : Unit.t
val centisecond : Unit.t
val millisecond : Unit.t
val microsecond : Unit.t
val nanosecond  : Unit.t

(* Current units *)
val teraampere  : Unit.t
val gigaampere  : Unit.t
val megaampere  : Unit.t
val kiloampere  : Unit.t
val hectoampere : Unit.t
val decaampere  : Unit.t
val ampere      : Unit.t
val deciampere  : Unit.t
val centiampere : Unit.t
val milliampere : Unit.t
val microampere : Unit.t
val nanoampere  : Unit.t

(* Temperature units *)
val terakelvin  : Unit.t
val gigakelvin  : Unit.t
val megakelvin  : Unit.t
val kilokelvin  : Unit.t
val hectokelvin : Unit.t
val decakelvin  : Unit.t
val kelvin      : Unit.t
val decikelvin  : Unit.t
val centikelvin : Unit.t
val millikelvin : Unit.t
val microkelvin : Unit.t
val nanokelvin  : Unit.t

(* Quantities of measurement *)
type length      = float
type mass        = float
type time        = float
type current     = float
type temperature = float
type quantity    =
  | Length of length * Unit.t
  | Mass of mass * Unit.t
  | Time of time * Unit.t
  | Current of current * Unit.t
  | Temperature of temperature * Unit.t
