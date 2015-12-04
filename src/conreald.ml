(* This is free and unencumbered software released into the public domain. *)

(** The `conreald` server daemon. *)

open Cmdliner
open Consensus
open Consensus.Prelude
open Consensus.Messaging
open Lwt.Infix
open Lwt_unix

(* Configuration *)

let version = "0.0.0"

let man_sections = [
  `S "DESCRIPTION";
  `P "Runs the Conreality daemon.";
  `S "BUGS";
  `P "Check open bug reports at <https://github.com/conreality/conreality/issues>.";
  `S "SEE ALSO";
  `P "$(b,concfg)(8), $(b,conctl)(8)";
]

let broker_name = "localhost"
let broker_port = 61613 (* Apache ActiveMQ Apollo *)

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

let connect addr port =
  let sockfd = Lwt_unix.socket Lwt_unix.PF_INET Lwt_unix.SOCK_STREAM 0 in
  let sockaddr = Lwt_unix.ADDR_INET (addr, port) in
  Lwt_unix.connect sockfd sockaddr
  >>= fun () -> Lwt.return (sockfd)

let send sockfd message =
  let channel = Lwt_io.of_fd sockfd ~mode:Lwt_io.output in
  Lwt_io.write channel message
  >>= fun () -> Lwt_io.flush channel

let recv_line sockfd =
  let channel = Lwt_io.of_fd sockfd ~mode:Lwt_io.input in
  Lwt_io.read_line channel

let hello sockfd =
  let frame = STOMP.Protocol.make_connect_frame "localhost" "admin" "password" in
  send sockfd (STOMP.Frame.to_string frame)
  >>= fun () -> recv_line sockfd
  >>= fun (line) -> Printf.printf "%s\n" line; Lwt.return ()
  >>= fun () -> Lwt.return ()

let rec loop () =
  fst (Lwt.wait ())

let run () =
  Lwt_log.default := Lwt_log.syslog
    ~facility:`Daemon
    ~template:"$(name)[$(pid)]: $(message)" ();
  Lwt_engine.on_timer 60. true (fun _ ->
    Lwt_log.ign_info "Processed no requests in the last minute.") |> ignore; (* TODO *)
  Lwt_unix.on_signal Sys.sigint (fun _ -> Lwt_unix.cancel_jobs (); exit 0) |> ignore;
  Lwt_main.at_exit (fun () -> Lwt_log.notice "Shutting down...");
  Lwt_log.ign_notice "Starting up...";
  Lwt_unix.gethostbyname broker_name
  >>= fun host -> begin
    Lwt_log.ign_notice_f "Connecting to message broker at %s:%d..." host.h_name broker_port;
    connect (Array.get host.h_addr_list 0) broker_port
  end
  >>= fun (sockfd) -> hello sockfd
  >>= fun () -> loop ()

let main options mission =
  if String.is_empty mission
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
