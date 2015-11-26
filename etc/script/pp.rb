#!/usr/bin/env ruby
# This preprocessing script for `ocamlc` and `ocamlopt` expands any
# ppx_include-compatible %%include directives in *.{ml,mli} source files,
# as a workaround for bisect_ppx otherwise choking on those files.
ARGF.each_line do |line|
  line = case
    when line.include?('%%include')
      # Some preprocessing required.
      line.gsub(/\[%%include "([^"]+)"\]/) do |match|
        source_path = ARGF.filename # the current file
        source_dir = File.dirname(source_path)
        File.read(File.join(source_dir, $1))
      end
    else
      # No preprocessing required.
      line
  end
  puts line
end
