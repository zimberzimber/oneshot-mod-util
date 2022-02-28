require_relative("common.rb")

$to_remove = [
    "_______",
    "_______.png",
    "libpython3.7m.so.1.0",
    "libsteam_api.so",
    "oneshot",
    "steamshim",
        "lib/discord_game_sdk.so",
        "lib/libruby.so.3.0",
        "lib/oneshot",
            "lib/ruby/x86_64-linux"
]

def main()
    root = dir_prompt("Modded OneShot directory:")
    rake(root)
    delete_files_from(root, $to_remove)
end

run()