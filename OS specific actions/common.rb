require_relative("../common.rb")
require 'fileutils'

def rake(root)
    if Gem.find_files("rake").empty?
        if puts_getch("Couldn't find 'rake' gem. Install now? (y/n)") == 'y'
            Gem.install("rake")
        else
            raise "Must have 'rake' gem installed to complete the process."
        end
    end


    original_dir = Dir.pwd
    ruby_files = root + "/Ruby-files"
    
    raise "Missing `Ruby-files` directory at: #{ruby_files}" if !File.directory?(ruby_files)
    raise "Missing `Rakefile` at: #{ruby_files}" if !File.exist?(ruby_files + "/Rakefile")

    Dir.chdir(ruby_files)
    system("rake")
    Dir.chdir(original_dir)
    FileUtils.rm_rf(ruby_files)
end