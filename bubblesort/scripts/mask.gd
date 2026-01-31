extends Area2D
class_name mask

@export var aesthetic: aesthetics_picker

func add_accessory(accessory):
	accessory.reparent(self)

#current charm that is selected
var focus_charm

func _on_body_entered(body: Node2D) -> void:
	print("got something")
	if body is RigidBody2D:
		print("picked up" + body.name)
		focus_charm = body
		focus_charm.over_mask = true

func _on_body_exited(body: Node2D) -> void:
	if body == focus_charm:
		focus_charm.over_mask = false
		print("dropped off" + body.name)
		focus_charm = null
