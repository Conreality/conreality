(* This is free and unencumbered software released into the public domain. *)

open Ocamlbuild_plugin
open Command

let cxx = "c++" (*find_command ["clang++"; "g++"; "c++"]*)

let stdlib_dir = lazy begin
  let ocamlc_where = !Options.build_dir / (Pathname.mk "ocamlc.where") in
  let () = Command.execute ~quiet:true (Cmd(S[!Options.ocamlc; A"-where"; Sh">"; P ocamlc_where])) in
  String.chomp (read_file ocamlc_where)
end

let () =
  dispatch begin function

  | Before_options ->
    Options.use_ocamlfind := true

  | After_rules ->
    ocaml_lib ~extern:true "opencv_core";
    ocaml_lib ~extern:true "opencv_objdetect";

    dep  ["file:src/consensus/prelude.ml"]
         ["src/consensus/prelude/bool.ml";
          "src/consensus/prelude/bytes.ml";
          "src/consensus/prelude/char.ml";
          "src/consensus/prelude/float.ml";
          "src/consensus/prelude/int.ml";
          "src/consensus/prelude/math.ml";
          "src/consensus/prelude/option.ml";
          "src/consensus/prelude/posix.ml";
          "src/consensus/prelude/string.ml"];

    dep  ["file:src/consensus/prelude.mli"]
         ["src/consensus/prelude/bool.mli";
          "src/consensus/prelude/bytes.mli";
          "src/consensus/prelude/char.mli";
          "src/consensus/prelude/float.mli";
          "src/consensus/prelude/int.mli";
          "src/consensus/prelude/math.mli";
          "src/consensus/prelude/option.mli";
          "src/consensus/prelude/posix.mli";
          "src/consensus/prelude/string.mli"];

    dep  ["file:src/consensus/machinery.ml"]
         ["src/consensus/machinery/abstract.ml";
          "src/consensus/machinery/bcm2835.ml";
          "src/consensus/machinery/bcm2836.ml";
          "src/consensus/machinery/device.ml";
          "src/consensus/machinery/driver.ml";
          "src/consensus/machinery/sysfs.ml";
          "src/consensus/machinery/usb.ml";
          "src/consensus/machinery/v4l2.ml"];

    dep  ["file:src/consensus/machinery.mli"]
         ["src/consensus/machinery/abstract.mli";
          "src/consensus/machinery/bcm2835.mli";
          "src/consensus/machinery/bcm2836.mli";
          "src/consensus/machinery/device.mli";
          "src/consensus/machinery/driver.mli";
          "src/consensus/machinery/sysfs.mli";
          "src/consensus/machinery/usb.mli";
          "src/consensus/machinery/v4l2.mli"];

    dep  ["file:src/consensus/messaging.ml"]
         ["src/consensus/messaging/crpp.ml";
          "src/consensus/messaging/irc.ml";
          "src/consensus/messaging/mqtt.ml";
          "src/consensus/messaging/ros.ml";
          "src/consensus/messaging/stomp.ml";
          "src/consensus/messaging/topic.ml"];

    dep  ["file:src/consensus/messaging.mli"]
         ["src/consensus/messaging/crpp.mli";
          "src/consensus/messaging/irc.mli";
          "src/consensus/messaging/mqtt.mli";
          "src/consensus/messaging/ros.mli";
          "src/consensus/messaging/stomp.mli";
          "src/consensus/messaging/topic.mli"];

    dep  ["file:src/consensus/model.ml"]
         ["src/consensus/model/asset.ml";
          "src/consensus/model/intent_designation.ml";
          "src/consensus/model/network.ml";
          "src/consensus/model/object.ml";
          "src/consensus/model/object_color.ml";
          "src/consensus/model/object_shape.ml";
          "src/consensus/model/swarm.ml";
          "src/consensus/model/target.ml";
          "src/consensus/model/theater.ml";
          "src/consensus/model/threat_level.ml"];

    dep  ["file:src/consensus/model.mli"]
         ["src/consensus/model/asset.mli";
          "src/consensus/model/intent_designation.mli";
          "src/consensus/model/network.mli";
          "src/consensus/model/object.mli";
          "src/consensus/model/object_color.mli";
          "src/consensus/model/object_shape.mli";
          "src/consensus/model/swarm.mli";
          "src/consensus/model/target.mli";
          "src/consensus/model/theater.mli";
          "src/consensus/model/threat_level.mli"];

    dep  ["file:src/consensus/networking.ml"]
         ["src/consensus/networking/udp.ml"];

    dep  ["file:src/consensus/networking.mli"]
         ["src/consensus/networking/udp.mli"];

    dep  ["file:src/consensus/scripting.ml"]
         ["src/consensus/scripting/context.ml"];

    dep  ["file:src/consensus/scripting.mli"]
         ["src/consensus/scripting/context.mli"];

    dep  ["link"; "ocaml"; "use_cxx"] ["src/libconreality.a"];

    flag ["link"; "ocaml"; "library"; "byte"; "use_cxx"]
      (S[A"-dllib"; A"-lconreality";
         A"-cclib"; A"src/libconreality.a"]);

    flag ["link"; "ocaml"; "library"; "native"; "use_cxx"]
      (S[A"-cclib"; A"src/libconreality.a"]);

    flag ["link"; "ocaml"; "program"; "byte"; "use_cxx"]
      (S[A"-dllpath"; A"_build/src";
         A"-dllib"; A"-lconreality";
         A"-cclib"; A"src/libconreality.a"]);

    flag ["link"; "ocaml"; "program"; "native"; "use_cxx"]
      (S[A"-cclib"; A"-rdynamic";
         A"-cclib"; A"-Wl,--whole-archive";
         A"-cclib"; A"src/libconreality.a";
         A"-cclib"; A"-Wl,--no-whole-archive"]);

    rule "ocaml C++ stubs: cc -> o"
      ~prod:"%.o"
      ~dep:"%.cc"
      begin fun env _build ->
        let cc = env "%.cc" in
        let o = env "%.o" in
        let tags = tags_of_pathname cc ++ "c++" ++ "compile" in
        Cmd(S[A cxx; T tags; A"-c"; A"-I"; A !*stdlib_dir; A"-fPIC"; A"-o"; P o; Px cc])
      end

  | _ -> ()
  end
