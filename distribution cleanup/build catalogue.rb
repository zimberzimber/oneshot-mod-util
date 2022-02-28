require_relative("common.rb")

def main()
	catalogue = {}
	root = dir_prompt("Vanilla OneShot directory:")

	scan_files(root, "",  -> (full, relative) {
		puts relative
		catalogue[relative] = hash_file(full)
	})

	catalogueFile = File.open("catalogue.json", "w+")
	catalogueFile.print(catalogue.to_json)
	catalogueFile.close()
end

run()