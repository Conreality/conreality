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
  | After_rules ->
     ocaml_lib ~extern:true "opencv_core";
     ocaml_lib ~extern:true "opencv_objdetect";
     dep  ["link"; "ocaml"; "use_vision"] ["src/consensus/libconsensus-vision.a"];
     flag ["link"; "library"; "ocaml"; "byte"; "use_vision"] (S[A"-dllib"; A"-lconsensus-vision"; A"-cclib"; A"-lconsensus-vision"]);
     flag ["link"; "library"; "ocaml"; "native"; "use_vision"] (S[A"-cclib"; A"-lconsensus-vision"]);
     rule "ocaml C++ stubs: cc -> o"
       ~prod:"%.o"
       ~dep:"%.cc"
       begin fun env _build ->
         let cc = env "%.cc" in
         let o = env "%.o" in
         let tags = tags_of_pathname cc ++ "c++" ++ "compile" in
         Cmd(S[A cxx; T tags; A"-c"; A"-I"; A !*stdlib_dir; A"-o"; P o; Px cc])
       end;
  | _ -> ()
  end
