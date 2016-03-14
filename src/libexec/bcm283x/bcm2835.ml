(* This is free and unencumbered software released into the public domain. *)

(* exception Not_a_pwm_pin of string *)

let pi1_bcm2708_peri_base = 0x20000000 (* Pi 1 *)
let pi2_bcm2708_peri_base = 0x3F000000 (* Pi 2 *)
let bcm2708_peri_base     = pi2_bcm2708_peri_base
let block_size            = 4*1024

module Pin =
struct
  (* for now only pwm pins *)
  exception Unknown_pin of int

  type pin = P12_BCM18 | P35_BCM19 | P32_BCM12 | P33_BCM13
  (* first part is the physical pin and the end is the BCM pin number *)

  (* should users use the physical pin number or the BCM number? *)
  let of_int pin_no =
    match pin_no with
    | 12 -> P32_BCM12
    | 13 -> P33_BCM13
    | 18 -> P12_BCM18
    | 19 -> P35_BCM19
    | _  -> raise (Unknown_pin pin_no)

  let to_string pin =
    match pin with
    | P32_BCM12 -> "P32_BCM12"
    | P33_BCM13 -> "P33_BCM13"
    | P12_BCM18 -> "P12_BCM18"
    | P35_BCM19 -> "P35_BCM19"
end

module Gpio =
struct
  (* needed to turn mode of pins to pwm and to turn pins off before conversion *)
  open Int32

  (* datasheet has different address for these registers 0xFE000000 *)
  let base    = Int32.of_int (bcm2708_peri_base + 0x00200000)
  (* let pads = (bcm2708_peri_base + 0x00100000) *)
  let len     = block_size (* need page alignment for mmap *)
  let regs    = Mmap32.mmap base len

  let set_mode_to_pwm pin =
    (* fixme: turn off pin before  conversion *)
    (* Port function select bits *)
    (* let fsel_inpt = 0b000 in *)
    (* let fsel_outp = 0b001 in *)
    let fsel_alt0 = Int32.of_int 0b100 in
    (* let fsel_alt1 = 0b101 in *)
    (* let fsel_alt2 = 0b110 in *)
    (* let fsel_alt3 = 0b111 in *)
    (* let fsel_alt4 = 0b011 in *)
    let fsel_alt5 = Int32.of_int 0b010 in
    let fsel = 1 in (* same for these four pins *)
    let update_reg shift alt = (
      let val_read = Mmap32.read regs fsel in
      let value = (logor (logand val_read (lognot (shift_left (Int32.of_int 0b111) shift))) (shift_left alt shift)) in
      (Mmap32.write regs fsel value)) in
    let shift =  match pin with
      | Pin.P32_BCM12 -> 6
      | Pin.P33_BCM13 -> 9
      | Pin.P12_BCM18 -> 24
      | Pin.P35_BCM19 -> 27 in
    let alt =  match pin with
      | Pin.P32_BCM12 -> fsel_alt0
      | Pin.P33_BCM13 -> fsel_alt0
      | Pin.P12_BCM18 -> fsel_alt5
      | Pin.P35_BCM19 -> fsel_alt5 in
    (update_reg shift alt; Time.delay_microseconds 110; ())

  (* fixme: add function to turn off gpio pin before converting it to pwm *)
end

module Pwm =
struct
  type mode = Mode_pwm_ms | Mode_pwm_bal (* two different modes of pwm *)
  type channel = Chan_0 | Chan_1         (* pwm hw has two channels *)

  let base       = Int32.of_int (bcm2708_peri_base + 0x0020C000)
  let len        = block_size  (* need to take a full block for mmap *)
  let regs       = Mmap32.mmap base len
  let control    = 0    (* word offset of pwm ctl register *)
  let status     = 1    (* word offset of pwm status register *)
  let pwm0_range = 4    (* word offset of pwm0 range register (byte offset 0x10) *)
  let pwm1_range = 8    (* word offset of pwm1 range register (byte offset 0x20) *)
  let pwm0_data  = 5    (* word offset of pwm1 range register (byte offset 0x14) *)
  let pwm1_data  = 9    (* word offset of pwm1 range register (byte offset 0x24) *)
  let range      = 4000 (* using a pwm range of 4000 makes the pwm run at 50Hz *)

  let channel_of_pin pin =
    match pin with
    | Pin.P32_BCM12 -> Chan_0
    | Pin.P33_BCM13 -> Chan_1
    | Pin.P12_BCM18 -> Chan_0
    | Pin.P35_BCM19 -> Chan_1

  let set_pwm_mode pin mode =
    let pwm_control = Mmap32.read regs control in (* to preserve pwm_control settings of other chan *)
    let shift       = 8 in
    let mask0       = Int32.lognot 0b11111111l in
    let mask1       = Int32.lognot (Int32.shift_left 0b11111111l shift) in
    let write_mode mask value =
      Mmap32.write regs control (Int32.logor (Int32.logand pwm_control mask) value) in

    match channel_of_pin pin with
    | Chan_0 ->
      let pwm0_ms_mode      = 0x0080 in  (* Run in MS mode *)
      (* let clr_fifo       = 0x0040 in *)
      (* let pwm0_usefifo   = 0x0020 in // Data from FIFO *)
      (* let pwm0_revpolar  = 0x0010 in // Reverse polarity *)
      (* let pwm0_offstate  = 0x0008 in // Ouput Off state *)
      (* let pwm0_repeatff  = 0x0004 in // Repeat last value if FIFO empty *)
      (* let pwm0_serial    = 0x0002 in // Run in serial mode *)
      let pwm0_enable       = 0x0001 in (* Channel Enable *)
      (match mode with
      | Mode_pwm_ms  -> write_mode mask0 (Int32.of_int(pwm0_enable lor pwm0_ms_mode))
      | Mode_pwm_bal -> write_mode mask0 (Int32.of_int pwm0_enable )
      )
    | Chan_1 ->
      let pwm1_ms_mode      = 0x8000 in (* Run in MS mode *)
      (* let pwm1_usefifo   = 0x2000 in // Data from FIFO *)
      (* let pwm1_revpolar  = 0x1000 in // Reverse polarity *)
      (* let pwm1_offstate  = 0x0800 in // Ouput Off state *)
      (* let pwm1_repeatff  = 0x0400 in // Repeat last value if FIFO empty *)
      (* let pwm1_serial    = 0x0200 in // Run in serial mode *)
      let pwm1_enable       = 0x0100 in (* Channel Enable *)
      (match mode with
      | Mode_pwm_ms  -> write_mode mask1 (Int32.of_int(pwm1_enable lor pwm1_ms_mode))
      | Mode_pwm_bal -> write_mode mask1 (Int32.of_int pwm1_enable)
      )

  let set_pwm_range pin range =
    let range32 = Int32.of_int range in
    (* set range only for the according channel *)
    match channel_of_pin pin with
    | Chan_0 -> ( Mmap32.write regs pwm0_range range32 ; Time.delay_microseconds 10 )
    | Chan_1 -> ( Mmap32.write regs pwm1_range range32 ; Time.delay_microseconds 10 )

  let get_pwm_range pin =
    (* get range only for the according channel *)
    Int32.to_int (
      match channel_of_pin pin with
      | Chan_0 -> Mmap32.read regs pwm0_range
      | Chan_1 -> Mmap32.read regs pwm1_range
    )

  let get_pulse_data pin =
    Int32.to_int (
      match channel_of_pin pin with
      | Chan_0 -> Mmap32.read regs pwm0_data
      | Chan_1 -> Mmap32.read regs pwm1_data
    )

  let set_pulse_data pin pulse_data =
    (* fixme: make sure pulse_data is less than range *)
    let pd = Int32.of_int pulse_data in
    match channel_of_pin pin with
    | Chan_0 -> Mmap32.write regs pwm0_data pd
    | Chan_1 -> Mmap32.write regs pwm1_data pd

end

module Clock =
struct
  (* for setting divisor *)
  exception Clock_value_out_of_range of int

  let base                    = Int32.of_int (bcm2708_peri_base + 0x00101000)
  let len                     = block_size
  let regs                    = Mmap32.mmap base len
  let cntl                    = 40 (* Clock register offsets *)
  let div                     = 41 (* Clock register offsets *)
  let bcm_password            = 0x5A000000l (* BCM Magic *)
  let raspberrypi2_clock_freq = 19200000
  (* range of divisor must be between 2 and 4095 *)
  let divisor = 96 (* leaving us with 200kHz, which should be sufficient for servos *)

  let set_divisor divisor =
    let _ =
      if ((divisor < 2) || (divisor > 4095))
      then raise (Clock_value_out_of_range divisor) in
    let pwm_control = Mmap32.read Pwm.regs Pwm.control in      (* preserve pwm_control *)
    (* We need to stop pwm prior to stopping pwm clock in MS mode otherwise BUSY stays high. *)
    begin
      Mmap32.write Pwm.regs Pwm.control (Int32.of_int 0);      (* Stop pwm *)
      (* Stop pwm clock before changing divisor. The delay after this does need to
      this big (95uS occasionally fails, 100uS OK), it's almost as though the BUSY
      flag is not working properly in balanced mode. Without the delay when DIV is
      adjusted the clock sometimes switches to very slow, once slow further DIV
      adjustments do nothing and it's difficult to get out of this mode. *)
      Mmap32.write regs cntl (Int32.logor bcm_password 0x01l); (* Stop Clock *)
      Time.delay_microseconds 110;                                (* prevents clock going sloooow *)
      (while ((Int32.to_int (Mmap32.read regs cntl) land 0x80) != 0) (* Wait for clock to be !BUSY *)
        do (Time.delay_microseconds 1) done; ());
      let clk = Int32.logor bcm_password (Int32.shift_left (Int32.of_int divisor) 12) in
      Mmap32.write regs div clk;                               (* write new divisor *)
      Mmap32.write regs cntl (Int32.logor bcm_password  0x11l);(* Start pwm clock *)
      Mmap32.write Pwm.regs Pwm.control pwm_control;           (* restore pwm_control *)
      ()
    end

  let get_divisor () =
    ((Int32.to_int (Mmap32.read regs div)) lsr 12)

end

let init_pin ?(divisor = Clock.divisor) pin = begin
  (* turn gpio pin into pwm pin *)
  (* FIXME not implemented writing to gpio "Gpio.write pin 0;" to turn pin off *)
  Gpio.set_mode_to_pwm pin;
  (* set_pwm_mode pin Mode_bal;         Pi default mode, I don't think we want balanced mode *)
  Pwm.set_pwm_mode pin Pwm.Mode_pwm_ms;
  Clock.set_divisor divisor;
  Pwm.set_pwm_range pin Pwm.range;         (* Default servo freq = 50Hz, otherwise set divisor and range above *)
  ()
end

let get_frequency pin =
  (Clock.raspberrypi2_clock_freq / Clock.get_divisor()) / Pwm.get_pwm_range pin

let set_frequency pin frequency =
  (* frequency in Hz
     if frequency goes too high, then resolution will drop
     and the divisor should be adjusted
     normally you would call this only once on initialization or never
     raspberrypi2_clock_freq = 19200000
     initially divisor is set to 96 -> 200kHz / range
     So if range = 4000 then you get 200kHz/4000=50Hz
     Be careful when changing the divisor as it affects both pwm chanels *)
  let range = (Clock.raspberrypi2_clock_freq / Clock.get_divisor()) / frequency in
  Pwm.set_pwm_range pin range

(* get the pulse_width in ms *)
let get_pulse_width pin =
  let freq = float_of_int (get_frequency pin) in
  let range = float_of_int (Pwm.get_pwm_range pin) in
  let pulse_data = float_of_int (Pwm.get_pulse_data pin) in
  pulse_data *. 1000. /. (freq *. range)

(* set the pulse_width in ms *)
let set_pulse_width pin pulse_width =
  let freq = float_of_int (get_frequency pin) in
  let range = float_of_int (Pwm.get_pwm_range pin) in
  let pulse_data = int_of_float (floor (0.5 +. pulse_width *. range *. freq /. 1000.)) in
  (* fixme: make sure pulse width is less than length of one pulse *)
  Pwm.set_pulse_data pin pulse_data

