extends RigidBody2D

var accessory_scene := preload('res://scenes/accessory_scene.tscn')
@onready var spawnpoint: = $spawnpoint
var on_screen = false

func _ready():
	global_position = Vector2(-500, 600)

func add_charm(new_charm_resource: Resource):
	var new_charm := accessory_scene.instantiate()
	new_charm.accessory = new_charm_resource
	new_charm.global_position = spawnpoint.global_position
	add_child(new_charm)

@onready var animator = $animator
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("A"):
		if on_screen:
			$CharmInstruction.visible = true
			on_screen = false
		else:
			$CharmInstruction.visible = false
			on_screen = true

@export var path: Curve
func _process(d):
	if on_screen:
		var dist = -((290.0 - position.x-790)/790.0)
		var weight = path.sample(dist) * 0.1
		position.x = lerp(position.x, 290.0, weight)
	else:
		var dist = ((-500.0 - position.x-790)/790.0)
		var weight = path.sample(dist) * 0.2
		position.x = lerp(position.x, -500.0, weight)

func phase_out():
	for child in get_children():
		if child is RigidBody2D:
			child.set_collision_layer_value(1, false)
			child.set_collision_mask_value(1, false)
	

func phase_in():
	for child in get_children():
		if child is RigidBody2D:
			child.set_collision_layer_value(1, true)
			child.set_collision_mask_value(1, true)
