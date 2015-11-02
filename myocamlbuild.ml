open Ocamlbuild_plugin
open Command

let () =
  dispatch begin function
  | After_rules ->
     ocaml_lib ~extern:true "opencv_core";
     ocaml_lib ~extern:true "opencv_objdetect";
  | _ -> ()
  end
