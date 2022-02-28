# Distributable Mod Package Preparation Utility

An utility for cleaning up files identical to vanilla since only modified files are to be distributed via platforms such as Itch

Run `build catalogue.rb` to create a catalogue of vanilla OneShot files
It will ask for a path to the vanilla OneShot game directory, then generate `catalogue.json` based on the contents
`catalogue.json` is required for comparison
**You only need to build it when it's missing, or if vanilla OneShot had an update**

Run `compare.rb` to compare a modded variation of OneShot to the content of `catalogue.json`
It will find missing, modified, and unmodified files, and will ask if you'd like them listed
It will then ask if you'd like to delete identical file from the mods directory