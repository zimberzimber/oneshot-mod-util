#!/usr/bin/ruby
require_relative "common.rb"
require "fileutils"

def main()
    raise "Only Windows and Linux are supported!" unless OS.windows? || OS.linux?

    template_dir = try_get_dir_from_argv(message:"Modded template directory:")
    output_root = "#{__dir__}/out"
    steam_root = output_root + "/steam"
    itch_root = output_root + "/itch"

    puts "Clearing output folder..."
    FileUtils.rm_rf(output_root)
    FileUtils.mkdir_p(steam_root)
    FileUtils.mkdir_p(itch_root)

    puts "Copying template..."

    topmost_items = []
    Dir.foreach(template_dir) do |file|
		next if ['.', '..', ".git"].include?(file)
        topmost_items.push("#{template_dir}/#{file}")
	end

    FileUtils.cp_r(topmost_items, steam_root)

    puts "Dev clean up..."
    require_relative("dev cleanup/cleanup.rb")
    Dev_Cleanup.run(steam_root)
    
    puts "OS specific up..."
    require_relative("OS specific actions/#{OS.windows? ? "windows" : "linux"}.rb")
    OS_Specific_Actions.run(steam_root)
    
    puts "Creating Itch duplicate..."
    FileUtils.copy_entry(steam_root, itch_root)

    puts "Itch cleanup..."
    require_relative("distribution cleanup/compare.rb")
    Distribution_Cleanup.run(itch_root)
end

main()
puts("> Jobs done!")