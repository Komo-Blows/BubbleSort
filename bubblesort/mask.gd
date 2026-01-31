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
	
