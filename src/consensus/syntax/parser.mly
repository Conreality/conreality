(* This is free and unencumbered software released into the public domain. *)

%token <int> INTEGER
%token EOF

%{
  open Node
%}

%start <Node.t> parse

%%

parse:
  | command EOF { $1 }

command:
  | n = INTEGER { Integer (n) }
