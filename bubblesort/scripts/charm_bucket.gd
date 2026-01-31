extends RigidBody2D

var accessory_scene := preload('res://scenes/accessory_scene.tscn')
@onready var spawnpoint: Vector2 = $spawnpoint.position

func add_charm(new_charm_resource: Resource):
	var new_charm := accessory_scene.instantiate()
	new_charm.accessory = new_charm_resource
	new_charm.position = spawnpoint
	add_child(new_charm)
	
