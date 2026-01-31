extends Area2D
class_name mask

@export var aesthetic: aesthetics_picker


#current charm that is selected
var focus_charm

func _on_body_entered(body: Node2D) -> void:
	if body is RigidBody2D:
		focus_charm = body
		focus_charm.over_mask = true

func _on_body_exited(body: Node2D) -> void:
	if body == focus_charm:
		focus_charm.over_mask = false
		focus_charm = null

func _process(_d):
	if focus_charm and focus_charm.stuck:
		focus_charm.reparent(self)
		focus_charm.attach(self)
		# add mask aesthetics to self
		aesthetic.add(focus_charm.aesthetic)
		focus_charm = null
