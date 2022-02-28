require_relative("../common.rb")
require "digest"
require "json"

def scan_files(root, relative, proc)
	full = root + relative
	Dir.foreach(full) do |file|
		next if file == '.' || file == '..'

        relativeFile = "#{relative}/#{file}"
        fullFile = "#{full}/#{file}"
        
		if File.directory?(fullFile)
			scan_files(root, relativeFile, proc)
		else
            proc.call(fullFile, relativeFile)
		end
	end
end

def hash_file(file)
	return Digest::SHA2.hexdigest(File.read(file, mode: "rb")).to_s
end