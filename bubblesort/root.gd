extends Node2D

@onready
var child = $character

func update_character():
	child.update()

var charm_folder = 'res://accessories/'
func _ready():
	var files = DirAccess.get_files_at(charm_folder)
	for file in files:
		var charm_resource = load(charm_folder + file)
		$charm_bucket.add_charm(charm_resource)
