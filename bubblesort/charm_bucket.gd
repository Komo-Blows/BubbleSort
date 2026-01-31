extends RigidBody2D

var accessory_scene = preload('res://scenes/accessory_scene.tscn')

func add_charm(new_charm_resource: Resource):
	var new_charm = accessory_scene.instantiate()
	new_charm.accessory = new_charm
	
