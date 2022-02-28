require_relative("common.rb")

def main()
	root = nil
	catalogue = {}

	puts "Vanilla OneShot directory:"

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

	scanFiles(root, "",  -> (full, relative) {
		puts relative
		catalogue[relative] = hashFile(full)
	})

	catalogueFile = File.open("catalogue.json", "w+")
	catalogueFile.puts(catalogue.to_json)
	catalogueFile.close()

	puts nil, "Jobs done!"
	STDIN.getch
end

def scan(relative="")
	full = $root + relative
	Dir.foreach(full) do |fileName|
		next if fileName == '.' || fileName == '..'

		fullFileName = "#{full}/#{fileName}"
		if File.directory?(fullFileName)
			scan("#{relative}/#{fileName}")
		else
			puts fullFileName
			$catalogue["#{relative}/#{fileName}"] = hashFile(fullFileName)
		end
	end
end

begin
	main()
rescue => error
	puts error.message
	STDIN.getch
end