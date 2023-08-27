require "git"
target_text = ARGV
dir_current = Dir.getwd
git_client = Git.open(dir_current)
target_text_before = target_text[0]
target_text_after = target_text[1]
git_client.grep(target_text_before).each do |file|
  file[0].scan(/\b:[^;]+/).map do |s|
    target_file = s.split(':').last
    target_file_text = File.open(target_file, "r") { |f| f.read() }

    target_file_text.gsub!(target_text_before, target_text_after)
    pp target_file_text
    File.open(target_file, "w") { |f| f.write(target_file_text) }
  end
end
