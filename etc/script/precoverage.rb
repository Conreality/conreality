#!/usr/bin/env ruby
# This script copies the contents of the src/ and test/ top-level
# directories into a _bisect/ temporary directory, preprocessing any
# *.{ml,mli} source files containing %%include directives in order to
# remove their ppx_include dependency (for bisect_ppx compatibility).
require 'fileutils'

# This is the target directory, which will be created if needed:
TARGET_DIR    = ENV['TARGET_DIR'] || '_bisect'

# The *.{ml,mli} files in these directories get preprocessed:
SOURCE_DIRS   = %w(src test).join(',')

# These files are copied over to the target directory as-is:
SOURCE_FILES  = %w(Makefile META.in VERSION myocamlbuild.ml _tags)
SOURCE_FILES << 'src/consensus.{itarget,mlpack}'
SOURCE_FILES << 'src/consensus/*.{clib,cc}'
SOURCE_FILES << 'test/*.{itarget,sh}'

FileUtils.mkdir_p TARGET_DIR

Dir[*SOURCE_FILES].sort.each do |source_path|
  target_path = File.join(TARGET_DIR, source_path)
  FileUtils.mkdir_p File.dirname(target_path)
  FileUtils.cp source_path, target_path
end

Dir["{#{SOURCE_DIRS}}/**/*.{ml,mli}"].sort.each do |source_path|
  target_path = File.join(TARGET_DIR, source_path)
  FileUtils.mkdir_p File.dirname(target_path)

  source_dir  = File.dirname(source_path)
  source_text = File.read(source_path)

  if source_text.each_line.any? { |line| line.include?('%%include') }
    # Some preprocessing required.
    target_text = source_text.gsub(/\[%%include "([^"]+)"\]/) do |match|
      File.read(File.join(source_dir, $1))
    end
    File.open(target_path, 'w+') do |target_file|
      target_file.write target_text
    end
  else
    # No preprocessing required.
    FileUtils.cp source_path, target_path
  end
end
