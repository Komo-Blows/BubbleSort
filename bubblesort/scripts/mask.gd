extends Area2D
class_name mask

var techy : int = 0
var fishy : int = 0
var cutesy : int = 0
var preppy : int = 0
var ugly : int = 0
var demonic : int = 0
var cowboy : int = 0
var irish : int = 0
var badly_drawn : int = 0

func add_accessory(accessory):
	self.reparent(accessory)

#current charm that is selected
var focus_charm

func _on_body_entered(body: Node2D) -> void:
	print("got something")
	if body is RigidBody2D:
		print("picked up" + body.name)
		focus_charm = body

func _on_body_exited(body: Node2D) -> void:
	if body == focus_charm:
		print("dropped off" + body.name)
		focus_charm = null
