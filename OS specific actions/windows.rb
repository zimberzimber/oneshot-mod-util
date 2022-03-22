require_relative("common.rb")

module OS_Specific_Actions
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
                "lib/ruby/x86_64-linux"
    ]

    def self.run(root)
        raise "Trying to run cleanup for Windows while not on Windows machine!" if !OS.windows?
        rake(root)
        delete_files_from(root, TO_REMOVE)
    end
end