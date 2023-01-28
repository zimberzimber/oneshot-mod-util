
root = ARGV[0].to_s
raise "Usage: build_catalogue.rb <directory to catalogue>" if ARGV.length < 1
raise "#{root} is not an existing directory." if !Dir.exist?(root)

require_relative("../common.rb")
require 'fileutils'

class OS_Action
    def run(root, files_to_remove)
        rake(root)
        delete_files_from(root, files_to_remove)
    end
    
    def rake(root)
        original_dir = Dir.pwd
        ruby_files = root + "/Ruby-files"
    
        raise "Missing `Ruby-files` directory at: #{ruby_files}" if !File.directory?(ruby_files)
        raise "Missing `Rakefile` at: #{ruby_files}" if !File.exist?(ruby_files + "/Rakefile")

        if Gem.find_files("rake").empty?
            puts "> Couldn't find 'rake' gem, i/nstalling now..."
            Gem.install("rake")
        end
    
        Dir.chdir(ruby_files)
        puts "> Raking and building iseq..."
        system("rake build_iseq")
        Dir.chdir(original_dir)
        FileUtils.rm_rf(ruby_files)
    end
end

class Linux_Action
    TO_REMOVE = [
        "_______.exe",
        "oneshot.exe",
        "steam_api.dll",
        "steamshim.exe",
            "lib/discord_game_sdk.dll",
            "lib/libcrypto-1_1-x64.dll",
            "lib/libssl-1_1-x64.dll",
            "lib/oneshot.exe",
            "lib/OpenAL32.dll",
            "lib/SDL2.dll",
            "lib/sigc-vc120-2_0.dll",
            "lib/x64-vcruntime140-ruby300.dll",
            "lib/zlib1.dll",
                "lib/ruby/x64-mswin64_140",
    ]
    
    TO_CHMOD = [
        "oneshot",
        "steamshim",
        "lib/oneshot",
    ]

    def run(root)
        puts "> cmodding files..."
        system("chmod +rwx #{TO_CHMOD.join(' ')}")
        super(root, TO_REMOVE)
3    end
end

class Window_Action
    TO_REMOVE = [
        "_______",
        "_______.png",
        "libpython3.7m.so.1.0",
        "libsteam_api.so",
        "oneshot",
        "steamshim",
        "lib/discord_game_sdk.so",
        "lib/libruby.so.3.0",
        "lib/oneshot",
        "lib/ruby/x86_64-linux",
        "lib/libaudio.so.2",
        "lib/libxfconf-0.so.3"
    ]

    def self.run(root)
        super(root, TO_REMOVE)
    end
end

action_class = OS.windows? ? Windows_Action.new() : Linux_Action.new()
action_class.run(root)