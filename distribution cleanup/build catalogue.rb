require_relative("common.rb")

catalogue = {}
root = try_get_dir_from_argv(message: "Vanilla OneShot directory:")

scan_files(root, "",  -> (full, relative) {
	puts relative
	catalogue[relative] = hash_file(full)
})

catalogueFile = File.open("catalogue.json", "w+")
catalogueFile.print(catalogue.to_json)
catalogueFile.close()

puts("> Catalogue built!")