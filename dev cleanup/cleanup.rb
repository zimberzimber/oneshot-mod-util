raise "Usage: cleanup.rb <root path>" if ARGV.length < 1

root = ARGV[0].to_s
raise "#{root} is not an existing directory." if !Dir.exist?(root)

require_relative("../common.rb")

TO_REMOVE = [
    ".git",
    ".github",
    ".luminol",
    "Crashes",
    "Demos",
    "docs",
    "modfile",
    "Excluded-Content",
    # "Ruby-files", # Needed for the Rake step

    ".gitignore",
    ".semgrepignore",
    "Game.exe",
    "Game.ini",
    "in memory.rxproj",
    "in memory (old version).rxproj",
    "mkxp.json",
    "prev_compare.bat",
    "pull_compare.bat",
    "pull_compare.WinMerge",
    "run_fm",
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

delete_files_from(root, TO_REMOVE)