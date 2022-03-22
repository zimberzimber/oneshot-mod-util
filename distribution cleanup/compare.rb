require_relative("common.rb")

module Distribution_Cleanup
	STEAM_RELATED = [
		# Windows
		"steam_api.dll", 
		"steam_appid.txt", 
		"steamshim.exe",

		# Linux
		"steamshim",
		"libsteam_api.so"
	]

	def self.run(root)
	    cataloguePath = "#{__dir__}/catalogue.json"
	    raise "Missing catalogue file at #{cataloguePath}" if !File.exist?(cataloguePath)

		catalogue = {}
		begin
			catalogue = JSON.parse(File.read(cataloguePath).chomp)
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

		puts "- Nonexistent : #{nonexistent.length}"
		puts "- Identical   : #{identical.length}"
		puts "- Modified    : #{modified.length}"

		identical.each do |file|
			puts "> Deleting identical: #{file}"
			File.delete(file)
		end

		STEAM_RELATED.each do |name|
			file = "#{root}/#{name}"
			puts "> Deleting Steam file: #{file}"
			File.delete(file) if File.exist?(file)
		end
	end
end