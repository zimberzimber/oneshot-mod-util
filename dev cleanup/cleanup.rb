require_relative("../common.rb")
require 'fileutils'

module Dev_Cleanup
    TO_REMOVE = [
        ".git",
        ".github",
        "Crashes",
        "Demos",
        "docs",
        "modfile",
        # "Ruby-files", # Needed for the Rake step
    
        ".gitignore",
        ".semgrepignore",
        "Game.exe",
        "Game.ini",
        "in memory.rxproj",
        "in_memory_pancakes.rxproj",
        "log.txt",
        "mk_debug_save.exe",
        "OSFMOtherViewPipe_DontTouch",
        "pack.bat",
        "README.md",
        "RGSS104E.dll",
        "run.bat",
    
        "lib/nopopup",
        "lib/noreports",
        "lib/ruby/debase",
        "lib/ruby/ruby-debug-ide",

        "Audio/AMB/convert.bat",
        "Audio/AMB/convert_jampy.bat",
    ]

    def self.run(root)
        delete_files_from(root, TO_REMOVE)
    end
end

# root = try_get_dir_from_argv(message: "Modded OneShot directory:")