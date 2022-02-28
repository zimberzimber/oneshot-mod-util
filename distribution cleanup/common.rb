require "digest"
require "json"
require 'io/console'

def scanFiles(root, relative, proc)
	full = root + relative
	Dir.foreach(full) do |file|
		next if file == '.' || file == '..'

        relativeFile = "#{relative}/#{file}"
        fullFile = "#{full}/#{file}"
        
		if File.directory?(fullFile)
			scanFiles(root, relativeFile, proc)
		else
            proc.call(fullFile, relativeFile)
		end
	end
end

def hashFile(file)
	raw = File.read(file, mode: "rb")
	return Digest::SHA2.hexdigest(raw).to_s
end