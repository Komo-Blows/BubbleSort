extends Node

var root_scene = preload("res://scenes/root.tscn")
var blank_save = SaveObject.new()
func load_save(save: SaveObject = blank_save):
	get_tree().change_scene_to_file("res://scenes/root.tscn")
