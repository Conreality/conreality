#!/usr/bin/env ruby
# This script preprocesses any ppx_include-reliant *.{ml,mli} source files,
# writing the expanded output to the corresponding _build/ path.
require 'fileutils'
Dir['src/**/*.{ml,mli}'].sort.each do |source_path|
  source_dir  = File.dirname(source_path)
  source_text = File.read(source_path)
  if source_text.each_line.any? { |line| line.include?('#include') }
    build_text = source_text.gsub(/#include "([^"]+)"/) do |match|
      File.read(File.join(source_dir, $1))
    end
    build_path = File.join('_build', source_path)
    FileUtils.mkdir_p(File.dirname(build_path))
    File.open(build_path, 'w+') do |build_file|
      build_file.write(build_text)
    end
  end
end
