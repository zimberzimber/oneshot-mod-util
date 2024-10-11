
raise "Trying to run cleanup for Windows while not on Windows machine!" if !OS.windows?

root = ARGV[0].to_s
raise "#{root} is not an existing directory." if !Dir.exist?(root)

require_relative("common.rb")

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

rake(root)
delete_files_from(root, TO_REMOVE)