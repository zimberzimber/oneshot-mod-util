require_relative("common.rb")

def main()
	puts "Modded OneShot directory:"

    cataloguePath = "#{__dir__}/catalogue.json"
    if !File.exist?(cataloguePath)
        puts "Missing catalogue file at #{cataloguePath}"
        STDIN.getch
        return
    end

	catalogue = {}
	begin
		catalogue = JSON.parse(File.read(cataloguePath).chomp)
	rescue => error
		puts "Failed parsing catalogue: #{error.message}"
        STDIN.getch
		return
	end
	
	root = nil
	loop do
		root = gets.chomp
		if Dir.exist?(root)
			if File.exist?(root + "/oneshot.exe")
				break
			else
				puts "Not a OneShot directory"
			end
		else
			puts "Not a directory"
		end
	end

	nonexistent = []
	identical = []
	modified = []

	catalogue.each do |relative, hash|
		full = "#{root}/#{relative}"
		puts "> Checking #{full}"
		if File.exist?(full)
			hash == hashFile(full) ? identical.push(full) : modified.push(full)
		else
			nonexistent.push(full)
		end
	end

	puts nil, "File check complete!"
	puts "- Nonexistent: #{nonexistent.length}"
	puts "- Identical: #{identical.length}"
	puts "- Modified: #{modified.length}"

	puts "List them? (y/n)"
	if STDIN.getch.downcase == 'y'
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

	puts nil, "Delete identical files? (y/n)"
	if STDIN.getch.downcase == 'y'
		identical.each do |file|
			puts "> Deleting #{file}"
			File.delete(file)
		end
	end

	puts nil, "Jobs done!"
	STDIN.getch
end

begin
	main()
rescue => error
	puts error.message
	STDIN.getch
end