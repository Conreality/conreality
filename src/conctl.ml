(* This is free and unencumbered software released into the public domain. *)

(** The `conctl` command-line interface. *)

open Cmdliner
open Consensus
open Consensus.Prelude

(* Configuration *)

let version = "0.0.0"

(* Option types *)

type verbosity = Normal | Quiet | Verbose

type common_options = { debug: bool; verbosity: verbosity }

let str = Printf.sprintf

let verbosity_str = function
  | Normal -> "normal" | Quiet -> "quiet" | Verbose -> "verbose"

(* Command implementations *)

let help options man_format commands topic = match topic with
  | None -> `Help (`Pager, None)
  | Some topic ->
      let topics = "topics" :: "environment" :: commands in
      let conv, _ = Cmdliner.Arg.enum (List.rev_map (fun s -> (s, s)) topics) in
      match conv topic with
      | `Error e -> `Error (false, e)
      | `Ok t when t = "topics" -> List.iter print_endline topics; `Ok ()
      | `Ok t when List.mem t commands -> `Help (man_format, Some t)
      | `Ok t ->
          let page = (topic, 7, "", "", ""), [`S topic; `P "Say something";] in
          `Ok (Cmdliner.Manpage.print man_format Format.std_formatter page)

let execute options script =
  let execute_script script =
    let context = Scripting.Context.create () in
    Scripting.Context.eval_file context script
  in
  if String.is_empty script
  then `Error (true, "no script specified")
  else `Ok (execute_script script)

let report options = (* TODO *)
  Consensus.Vision.hello ()

let toggle options device = Printf.printf
  "Toggled the %s device.\n" device (* TODO *)

(* Help sections common to all commands *)

let common_options_section = "COMMON OPTIONS"

let help_sections = [
  `S common_options_section;
  `P "These options are common to all commands:";
  `S "MORE HELP";
  `P "Use `$(mname) $(i,COMMAND) --help' for help on a single command."; `Noblank;
  `P "Use `$(mname) help environment' for help on environment variables.";
  `S "BUGS";
  `P "Check open bug reports at <https://github.com/conreality/conreality/issues>.";
]

(* Options common to all commands *)

let common_options debug verbosity = { debug; verbosity }

let common_options_term =
  let docs = common_options_section in
  let debug =
    let doc = "Give only debug output." in
    Arg.(value & flag & info ["debug"] ~docs ~doc)
  in
  let verbosity =
    let doc = "Suppress informational output." in
    let quiet = Quiet, Arg.info ["q"; "quiet"] ~docs ~doc in
    let doc = "Give verbose output." in
    let verbose = Verbose, Arg.info ["v"; "verbose"] ~docs ~doc in
    Arg.(last & vflag_all [Normal] [quiet; verbose])
  in
  Term.(const common_options $ debug $ verbosity)

(* Command definitions *)

let help_command =
  let topic =
    let doc = "The topic to get help on. `topics' lists the topics." in
    Arg.(value & pos 0 (some string) None & info [] ~docv:"TOPIC" ~doc)
  in
  let doc = "Display help on a topic." in
  let man = [
    `S "DESCRIPTION";
    `P "Displays help on a subcommand or topic."
  ] @ help_sections
  in
  Term.(ret (const help $ common_options_term $ Term.man_format $ Term.choice_names $ topic)),
  Term.info "help" ~doc ~man

let execute_command =
  let script =
    let doc = "The file path to the script to execute." in
    Arg.(value & pos 0 string "" & info [] ~docv:"SCRIPT" ~doc)
  in
  let doc = "Execute a script." in
  let man = [
    `S "DESCRIPTION";
    `P "Executes a Lua script."
  ] @ help_sections
  in
  Term.(ret (const execute $ common_options_term $ script)),
  Term.info "execute" ~doc ~man ~sdocs:common_options_section

let report_command =
  let doc = "Display a self-diagnosis report." in
  let man = [
    `S "DESCRIPTION";
    `P "Runs a self-diagnosis test."
  ] @ help_sections
  in
  Term.(const report $ common_options_term),
  Term.info "report" ~doc ~man ~sdocs:common_options_section

let toggle_command =
  let device =
    let doc = "The name of the device to toggle." in
    Arg.(value & pos 0 string "" & info [] ~docv:"DEVICE" ~doc)
  in
  let doc = "Toggle power to a device." in
  let man = [
    `S "DESCRIPTION";
    `P "Toggles direct current to a given device."
  ] @ help_sections
  in
  Term.(const toggle $ common_options_term $ device),
  Term.info "toggle" ~doc ~man ~sdocs:common_options_section

let default_command =
  let doc = "Control devices on the local node." in
  let man = help_sections in
  Term.(ret (const (fun _ -> `Help (`Pager, None)) $ common_options_term)),
  Term.info "conctl" ~version ~doc ~man ~sdocs:common_options_section

let commands = [help_command; execute_command; report_command; toggle_command]

let () =
  match Term.eval_choice default_command commands with
  | `Error _ -> exit 1 | _  -> exit 0
