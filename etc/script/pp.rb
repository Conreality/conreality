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

# In order to prevent the compiler from deleting the preprocessed output,
# stored in a temporary file, we must protect the file. bisect_ppx will
# want to access the file soon, so it better still exist at that time.
# NB: for this to work, this script must be invoked with superuser bits.
require 'fileutils'
Dir['/tmp/ocamlpp*'].each do |tmp_path|
  next if File.stat(tmp_path).uid.zero?
  FileUtils.chmod 0444, tmp_path rescue nil
  FileUtils.chown 'root', 'root', tmp_path rescue nil
end
