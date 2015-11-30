(* This is free and unencumbered software released into the public domain. *)

open Prelude

(* Dimensions of measurement *)
module Dimension = struct
  type t =
    | Length
    | Mass
    | Time
    | Current
    | Temperature
end

(* Scales of measurement *)
module Scale = struct
  type t = int

  (* See: https://en.wikipedia.org/wiki/Metric_prefix *)
  let symbol_and_label = function
    | 12    -> ("T",  "tera")
    | 9     -> ("G",  "giga")
    | 6     -> ("M",  "mega")
    | 3     -> ("k",  "kilo")
    | 2     -> ("h",  "hecto")
    | 1     -> ("da", "deca")
    | 0     -> ("",   "")
    | (-1)  -> ("d",  "deci")
    | (-2)  -> ("c",  "centi")
    | (-3)  -> ("m",  "milli")
    | (-6)  -> ("μ",  "micro")
    | (-9)  -> ("n",  "nano")
    | (-12) -> ("p",  "pico")
    | scale -> invalid_arg (Printf.sprintf "invalid scale: %d" scale)

  let symbol scale =
    let (symbol, _) = (symbol_and_label scale) in symbol

  let label scale =
    let (_, label) = (symbol_and_label scale) in label
end

(* Units of measurement *)
module Unit = struct
  type t = { dimension: Dimension.t; symbol: char; scale: Scale.t }

  let dimension unit = unit.dimension
  let symbol unit = (Char.to_string unit.symbol)
  let scale unit = unit.scale

  let to_string unit = (Scale.symbol unit.scale) ^ (symbol unit)

  let make dimension symbol scale = { dimension; symbol; scale }

  let length scale      = make Dimension.Length 'm' scale
  let mass scale        = make Dimension.Mass 'g' scale
  let time scale        = make Dimension.Time 's' scale
  let current scale     = make Dimension.Current 'A' scale
  let temperature scale = make Dimension.Temperature 'K' scale
end

(* Length units *)

let terameter   = Unit.length 12
let gigameter   = Unit.length 9
let megameter   = Unit.length 6
let kilometer   = Unit.length 3
let hectometer  = Unit.length 2
let decameter   = Unit.length 1
let meter       = Unit.length 0
let decimeter   = Unit.length (-1)
let centimeter  = Unit.length (-2)
let millimeter  = Unit.length (-3)
let micrometer  = Unit.length (-6)
let nanometer   = Unit.length (-9)
let picometer   = Unit.length (-12)

(* Mass units *)

let teragram    = Unit.mass 12
let gigagram    = Unit.mass 9
let megagram    = Unit.mass 6
let kilogram    = Unit.mass 3
let hectogram   = Unit.mass 2
let decagram    = Unit.mass 1
let gram        = Unit.mass 0
let decigram    = Unit.mass (-1)
let centigram   = Unit.mass (-2)
let milligram   = Unit.mass (-3)
let microgram   = Unit.mass (-6)
let nanogram    = Unit.mass (-9)
let picogram    = Unit.mass (-12)

(* Time units *)

let terasecond  = Unit.time 12
let gigasecond  = Unit.time 9
let megasecond  = Unit.time 6
let kilosecond  = Unit.time 3
let hectosecond = Unit.time 2
let decasecond  = Unit.time 1
let second      = Unit.time 0
let decisecond  = Unit.time (-1)
let centisecond = Unit.time (-2)
let millisecond = Unit.time (-3)
let microsecond = Unit.time (-6)
let nanosecond  = Unit.time (-9)
let picosecond  = Unit.time (-12)

(* Current units *)

let teraampere  = Unit.current 12
let gigaampere  = Unit.current 9
let megaampere  = Unit.current 6
let kiloampere  = Unit.current 3
let hectoampere = Unit.current 2
let decaampere  = Unit.current 1
let ampere      = Unit.current 0
let deciampere  = Unit.current (-1)
let centiampere = Unit.current (-2)
let milliampere = Unit.current (-3)
let microampere = Unit.current (-6)
let nanoampere  = Unit.current (-9)
let picoampere  = Unit.current (-12)

(* Temperature units *)

let terakelvin  = Unit.temperature 12
let gigakelvin  = Unit.temperature 9
let megakelvin  = Unit.temperature 6
let kilokelvin  = Unit.temperature 3
let hectokelvin = Unit.temperature 2
let decakelvin  = Unit.temperature 1
let kelvin      = Unit.temperature 0
let decikelvin  = Unit.temperature (-1)
let centikelvin = Unit.temperature (-2)
let millikelvin = Unit.temperature (-3)
let microkelvin = Unit.temperature (-6)
let nanokelvin  = Unit.temperature (-9)
let picokelvin  = Unit.temperature (-12)

(* Quantities *)

type length = float
type mass = float
type time = float
type current = float
type temperature = float

type quantity =
  | Length of length * Unit.t
  | Mass of mass * Unit.t
  | Time of time * Unit.t
  | Current of current * Unit.t
  | Temperature of temperature * Unit.t

module Quantity = struct
  type t = quantity

  let length = function
    | Length (magnitude, _) -> magnitude
    | _ -> assert false

  let mass = function
    | Mass (magnitude, _) -> magnitude
    | _ -> assert false

  let time = function
    | Time (magnitude, _) -> magnitude
    | _ -> assert false

  let current = function
    | Current (magnitude, _) -> magnitude
    | _ -> assert false

  let temperature = function
    | Temperature (magnitude, _) -> magnitude
    | _ -> assert false

  let magnitude = function
    | Length (magnitude, _) -> magnitude
    | Mass (magnitude, _) -> magnitude
    | Time (magnitude, _) -> magnitude
    | Current (magnitude, _) -> magnitude
    | Temperature (magnitude, _) -> magnitude

  let is_infinite value =
    Float.is_infinite (magnitude value)

  let inverse = function
    | Length (magnitude, unit) -> Length (Float.inverse magnitude, unit)
    | Mass (magnitude, unit) -> Mass (Float.inverse magnitude, unit)
    | Time (magnitude, unit) -> Time (Float.inverse magnitude, unit)
    | Current (magnitude, unit) -> Current (Float.inverse magnitude, unit)
    | Temperature (magnitude, unit) -> Temperature (Float.inverse magnitude, unit)
end
