extends Node2D

@onready
var child = $character
@onready
var animator = $AnimationPlayer

func new_character():
	animator.play("slide in")
	child.update()

var charm_folder = 'res://accessories/'
func _ready():
	# initialize Charms
	var files = DirAccess.get_files_at(charm_folder)
	for file in files:
		var charm_resource = load(charm_folder + file)
		$charm_bucket.add_charm(charm_resource)

	await get_tree().create_timer(1).timeout
	new_character()
