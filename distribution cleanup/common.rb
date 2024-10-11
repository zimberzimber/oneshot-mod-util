require_relative("../common.rb")
require "digest"
require "json"

def hash_file(file)
	return Digest::SHA2.hexdigest(File.read(file, mode: "rb")).to_s
end