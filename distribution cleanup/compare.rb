require_relative("common.rb")

module Distribution_Cleanup
	SKIP_CONFIRMATION = ARGV.include?("-y")

	def self.run(root)
	    cataloguePath = "#{__dir__}/catalogue.json"
	    raise "Missing catalogue file at #{cataloguePath}" if !File.exist?(cataloguePath)

		catalogue = {}
		begin
			catalogue = JSON.parse(File.read(cataloguePath).chomp)
		rescue => error
			raise puts_getch("Failed parsing catalogue: #{error.message}")
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

		puts nil, "File check complete!"
		puts "- Nonexistent: #{nonexistent.length}"
		puts "- Identical: #{identical.length}"
		puts "- Modified: #{modified.length}"

		if !SKIP_CONFIRMATION && puts_getch("List them? (y/n)") == 'y'
			if nonexistent.length > 0
				puts "========== MISSING FILES =========="
				nonexistent.each do |file| puts file end
				puts "========== MISSING FILES =========="
			end

			puts

			if modified.length > 0
				puts "========== MODIFIED FILES =========="
				modified.each do |file| puts file end
				puts "========== MODIFIED FILES =========="
			end

			puts

			if identical.length > 0
				puts "========== IDENTICAL FILES =========="
				identical.each do |file| puts file end
				puts "========== IDENTICAL FILES =========="
			end
		end

		if SKIP_CONFIRMATION || puts_getch("Delete identical files? (y/n)") == 'y'
			identical.each do |file|
				puts "> Deleting #{file}"
				File.delete(file)
			end
		end
	end
end

#root = try_get_dir_from_argv(message:"Modded OneShot directory:")