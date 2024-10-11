raise "Usage: cleanup.rb <template_root_path>" if ARGV.length < 1

template_root = ARGV[0]
raise "#{template_root} is not an existing directory." if !Dir.exist?(template_root)

require_relative "common.rb"
raise "Only Windows and Linux are supported!" unless OS.windows? || OS.linux?

require "fileutils"

output_root = "#{__dir__}/out"
steam_root = output_root + "/steam"
itch_root = output_root + "/itch"

puts "\n========== Clearing output folder...\n"
FileUtils.rm_rf(output_root)
FileUtils.mkdir_p(steam_root)
FileUtils.mkdir_p(itch_root)

puts "\n========== Copying template...\n"
topmost_items = []
Dir.foreach(template_root) do |file|
	next if IGNORED_DIRS.include?(file)
    topmost_items.push("#{template_root}/#{file}")
end

FileUtils.cp_r(topmost_items, steam_root)

puts "\n========== Dev clean up...\n"
ARGV[0] = steam_root
require_relative("dev cleanup/cleanup.rb")
    
puts "\n========== OS specific up...\n"
require_relative("OS specific actions/#{OS.windows? ? "windows" : "linux"}.rb")
    
puts "\n========== Creating Itch version...\n"
FileUtils.copy_entry(steam_root, itch_root)

puts "\n========== Itch cleanup...\n"
ARGV[0] = itch_root
require_relative("distribution cleanup/compare.rb")

puts "\n\nJobs done!"