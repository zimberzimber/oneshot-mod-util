require_relative("common.rb")

module OS_Specific_Actions
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

    def self.run(root)
        raise "Trying to run cleanup for Linux while not on Linux machine!" if !OS.linux?
        rake(root)
        delete_files_from(root, TO_REMOVE)
    end
end