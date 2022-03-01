require_relative("common.rb")

$to_remove = [
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
        "lib/x64-vcruntime140-ruby300",
        "lib/zlib1.dll",
            "lib/ruby/x64-mswin64_140",
]

def main()
    raise "Trying to run cleanup for Linux while not on Linux machine!" if !OS.linux?
    root = try_get_dir_from_argv(message:"Modded OneShot directory:")
    rake(root)
    delete_files_from(root, $to_remove)
end

run()