(* This is free and unencumbered software released into the public domain. *)

open Cmdliner
open Consensus
open Lwt.Infix

(* Configuration *)

let version = "0.0.0"

let man_sections = [
  `S "DESCRIPTION";
  `P "Runs the Conreality daemon.";
  `S "BUGS";
  `P "Check open bug reports at <https://github.com/conreality/consensus/issues>.";
  `S "SEE ALSO";
  `P "$(b,concfg)(8), $(b,conctl)(8)";
]

(* Option types *)

type verbosity = Normal | Quiet | Verbose

type common_options = { debug: bool; verbosity: verbosity }

let str = Printf.sprintf

let verbosity_str = function
  | Normal -> "normal" | Quiet -> "quiet" | Verbose -> "verbose"

(* Command implementations *)

let execute_script script =
  let context = Scripting.Context.create () in
  Scripting.Context.eval_file context script

let rec loop () =
  fst (Lwt.wait ())

let run () =
  Lwt_log.default := Lwt_log.syslog
    ~facility:`Daemon
    ~template:"$(name)[$(pid)]: $(message)" ();
  Lwt_engine.on_timer 60. true (fun _ ->
    Lwt_log.ign_info "Processed no requests in the last minute.") |> ignore;
  Lwt_unix.on_signal Sys.sigint (fun _ -> Lwt_unix.cancel_jobs (); exit 0) |> ignore;
  Lwt_main.at_exit (fun () -> Lwt_log.notice "Shutting down...");
  Lwt_log.notice "Starting up..."
  >>= fun () -> loop ()

let main options mission =
  if mission = ""
  then `Error (true, "no mission scenario script specified")
  else `Ok (Lwt_main.run (run ()))

(* Options common to all commands *)

let common_options debug verbosity = { debug; verbosity }

let common_options_term =
  let debug =
    let doc = "Enable debugging output." in
    Arg.(value & flag & info ["debug"] ~doc)
  in
  let verbosity =
    let doc = "Suppress informational output." in
    let quiet = Quiet, Arg.info ["q"; "quiet"] ~doc in
    let doc = "Give verbose output." in
    let verbose = Verbose, Arg.info ["v"; "verbose"] ~doc in
    Arg.(last & vflag_all [Normal] [quiet; verbose])
  in
  Term.(const common_options $ debug $ verbosity)

(* Command definitions *)

let command =
  let mission =
    let doc = "A file path to a mission scenario script." in
    Arg.(value & pos 0 string "" & info [] ~docv:"MISSION" ~doc)
  in
  let doc = "Conreality daemon." in
  let man = man_sections in
  Term.(ret (const main $ common_options_term $ mission)),
  Term.info "conreald" ~version ~doc ~man

let () =
  match Term.eval command with `Error _ -> exit 1 | _  -> exit 0
