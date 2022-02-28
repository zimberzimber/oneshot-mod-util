require 'io/console'

def dir_prompt(msg = "Working directory:")
	loop do
		root = puts_gets(msg)
		if Dir.exist?(root)
			if File.exist?(root + "/oneshot.exe")
				return root
			else
				puts "Not a OneShot directory"
			end
		else
			puts "Not a directory"
		end
	end
end

def puts_getch(msg)
    puts nil, msg.to_s
	return STDIN.getch.downcase
end

def puts_gets(msg)
    puts nil, msg.to_s
	return gets.chomp
end

def delete_files_from(root, files)
	files.each do |file|
        full = "#{root}/#{file}"
        if File.exist?(full)
            if File.directory?(full)
                puts "> Removing directory: #{full}"
                FileUtils.rm_rf(full)
            else
                puts "> Removing file: #{full}"
                File.delete(full)
            end
        else
            puts "> Not found: #{full}"
        end
    end
end

def run()
    begin
    	main()
		puts_getch("Jobs done!")
    rescue => error
    	puts error.to_s
    	STDIN.getch
    end
end