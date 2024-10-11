raise "Usage: compare.rb <target_directory>" if ARGV.length < 1

root = ARGV[0].to_s
raise "#{root} is not an existing directory." if !Dir.exist?(root)

catalogue_path = "#{__dir__}/catalogue.json"
raise "Missing catalogue file at #{catalogue_path}" if !File.exist?(catalogue_path)

require_relative("common.rb")

catalogue = {}
begin
	catalogue = JSON.parse(File.read(catalogue_path).chomp)
rescue => error
	raise "Failed parsing catalogue: #{error.message}"
end

nonexistent = []
identical = []
modified = []

catalogue.each do |relative, hash|
	full = "#{root}/#{relative}"
	puts "> Checking #{full}"
	if File.exist?(full)
		hash == hash_file(full) ? identical.push(full) : modified.push(full)
	else
		nonexistent.push(full)
	end
end

puts "\n=========================================================="
puts "# Nonexistent : #{nonexistent.length}"
puts "# Identical   : #{identical.length}"
puts "# Modified    : #{modified.length}"
puts "==========================================================\n"

identical.each do |file|
	puts "> Deleting identical file: #{file}"
	File.delete(file)
end

delete_empty_directories(root)

# MOVE THIS
STEAM_RELATED = [
	# Windows
	"steam_api.dll", 
	"steam_appid.txt", 
	"steamshim.exe",

	# Linux
	"steamshim",
	"libsteam_api.so"
]
STEAM_RELATED.each do |name|
	file = "#{root}/#{name}"
	if File.exist?(file)
		puts "> Deleting Steam file: #{file}"
		File.delete(file)
	end
end
