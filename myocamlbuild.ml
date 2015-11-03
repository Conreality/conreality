open Ocamlbuild_plugin
open Command

let () =
  dispatch begin function
  | After_rules ->
     ocaml_lib ~extern:true "opencv_core";
     ocaml_lib ~extern:true "opencv_objdetect";
     dep  ["link"; "ocaml"; "use_vision"] ["src/consensus/libconsensus-vision.a"];
     flag ["link"; "library"; "ocaml"; "byte"; "use_vision"] (S[A"-dllib"; A"-lconsensus-vision"; A"-cclib"; A"-lconsensus-vision"]);
     flag ["link"; "library"; "ocaml"; "native"; "use_vision"] (S[A"-cclib"; A"-lconsensus-vision"]);
  | _ -> ()
  end
