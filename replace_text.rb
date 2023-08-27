#!/usr/bin/env ruby

require "git"

def current_dirctory
  Dir.getwd
end

def repository
  Git.open(current_dirctory)
end

def replace_text(target_texts)
  target_text_before = target_texts[0]
  target_text_after = target_texts[1]

  git_repository = repository

  git_repository.grep(target_text_before).each do |results|
    results[0].scan(/\b:[^;]+/).each do |result|
      target_file = result.split(':').last
      target_file_text = File.open(target_file, "r") { |f| f.read }

      target_file_text.gsub!(target_text_before, target_text_after)
      File.open(target_file, "w") { |f| f.write(target_file_text) }
    end
  end
end

target_texts = ARGV
replace_text(target_texts)
