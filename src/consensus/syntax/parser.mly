%token <int> INTEGER
%token EOF

%start <int> parse_command

%%

command:
  | n = INTEGER { n }

parse_command:
  | command EOF { $1 }
