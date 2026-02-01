extends RigidBody2D

var accessory_scene := preload('res://scenes/accessory_scene.tscn')
@onready var spawnpoint: Vector2 = $spawnpoint.position
var on_screen = false

func add_charm(new_charm_resource: Resource):
	var new_charm := accessory_scene.instantiate()
	new_charm.accessory = new_charm_resource
	new_charm.position = spawnpoint
	add_child(new_charm)

@onready var animator = $animator
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("A"):
		if on_screen:
			animator.play("slide out")
			$CharmInstruction.visible = true
			on_screen = false
		else:
			animator.play("slide in")
			$CharmInstruction.visible = false
			on_screen = true
		

func phase_out():
	for child in get_children():
		if child is RigidBody2D:
			print("one")
			child.set_collision_layer_value(1, false)
			child.set_collision_mask_value(1, false)
				

func phase_in():
	for child in get_children():
		if child is RigidBody2D:
			child.set_collision_layer_value(1, true)
			child.set_collision_mask_value(1, true)
