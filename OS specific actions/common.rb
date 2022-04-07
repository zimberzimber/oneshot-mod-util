require_relative("../common.rb")
require 'fileutils'

def rake(root)
    if Gem.find_files("rake").empty?
        puts "> Couldn't find 'rake' gem."
        puts "> Installing now..."
        Gem.install("rake")
    end

    original_dir = Dir.pwd
    ruby_files = root + "/Ruby-files"
    
    raise "Missing `Ruby-files` directory at: #{ruby_files}" if !File.directory?(ruby_files)
    raise "Missing `Rakefile` at: #{ruby_files}" if !File.exist?(ruby_files + "/Rakefile")

    Dir.chdir(ruby_files)
    # system("rake build_iseq")
    system("rake")
    Dir.chdir(original_dir)
    FileUtils.rm_rf(ruby_files)
end