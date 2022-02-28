require_relative("../common.rb")
require 'fileutils'

$to_remove = [
    # ".git",
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
]

def main()
    root = dir_prompt("Modded OneShot directory:")
    delete_files_from(root, $to_remove)
end

run()