#!/usr/bin/env ruby
# frozen_string_literal: true

require 'git'

def replace_text(pattern, replace)
  git = Git.open(Dir.getwd)
  matches = git.grep(pattern).flat_map { |match| match.first.scan(/\b:[^;]+/) }
  file_paths = matches.map { |str| str.split(':').last }.uniq

  file_paths.each do |file_path|
    replaced_text = File.read(file_path).gsub(pattern, replace)

    File.write(file_path, replaced_text)
  end
end

replace_text(*ARGV)
