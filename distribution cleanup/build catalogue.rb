root = ARGV[0].to_s
raise "Usage: build_catalogue.rb <directory to catalogue>" if ARGV.length < 1
raise "#{root} is not an existing directory." if !Dir.exist?(root)

require_relative("common.rb")

catalogue = {}
each_file(root, "", -> (full, relative) {
	puts relative
	catalogue[relative] = hash_file(full)
})

catalogue_file = File.open("catalogue.json", "w+")
catalogue_file.print(catalogue.to_json)
catalogue_file.close()

puts "> Catalogue built"