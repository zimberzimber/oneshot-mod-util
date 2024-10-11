require 'io/console'

IGNORED_DIRS = [ ".", "..", ".git", ".vscode", ".idea", ".github", ".luminol" ]

def each_file(root, relative, proc)
	full = root + relative

	Dir.foreach(full) do |file|
		next if IGNORED_DIRS.include?(file)
		
		relative_file = "#{relative}/#{file}"
		full_file = "#{full}/#{file}"
        
		if File.directory?(full_file)
			each_file(root, relative_file, proc)
		else
			proc.call(full_file, relative_file)
		end
	end
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

def delete_empty_directories(root)
	Dir.glob( "**/", base: root ).reverse_each { |d|
		full = "#{root}/#{d}"
		if Dir.empty?(full)
			puts "> Deleting empty directory: #{full}"
			Dir.rmdir(full)
		end
	}
end





def dir_prompt(msg = "Working directory:")
	loop do
		dir = parse_dir_input(puts_gets(msg))
		return dir if dir_valid(dir)
	end
end

def dir_valid(dir)
	if Dir.exist?(dir)
		if File.exist?(dir + "/oneshot.exe")
			return true
		else
			puts "#{dir} is not a OneShot directory"
			return false
		end
	else
		puts "#{dir} is not an existing directory"
		return false
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


def parse_dir_input(dir)
	return "#{Dir.pwd}/#{dir}" if dir.class == String && dir[0].start_with?(".")
	return dir
end

# https://stackoverflow.com/a/171011
module OS
	def OS.windows?
		(/cygwin|mswin|mingw|bccwin|wince|emx/ =~ RUBY_PLATFORM) != nil
	end

	def OS.mac?
		(/darwin/ =~ RUBY_PLATFORM) != nil
	end

	def OS.unix?
		!OS.windows?
	end

	def OS.linux?
		OS.unix? && !OS.mac?
	end

	def OS.jruby?
		RUBY_ENGINE == 'jruby'
	end
end
  